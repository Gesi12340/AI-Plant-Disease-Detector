import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D, Dropout, Input
from tensorflow.keras.models import Model
from tensorflow.keras.optimizers import Adam
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping, ReduceLROnPlateau
import os
import numpy as np
import argparse

# --- Configuration ---
IMG_SIZE = 224
BATCH_SIZE = 32
EPOCHS = 20
LEARNING_RATE = 1e-4

def create_model(num_classes):
    """
    Creates a MobileNetV2 based model with two heads:
    1. Classification Head: Detects the disease
    2. Regression Head: Estimates severity (0-100%)
    """
    base_model = MobileNetV2(weights='imagenet', include_top=False, input_shape=(IMG_SIZE, IMG_SIZE, 3))
    
    # Freeze the base model initially
    base_model.trainable = False

    x = base_model.output
    x = GlobalAveragePooling2D()(x)
    x = Dropout(0.5)(x)

    # Classification Head
    class_output = Dense(num_classes, activation='softmax', name='disease_output')(x)

    # Severity Head (Regression)
    # Note: Training this requires severity labels. If not available, we can rely on visual inspection 
    # or heuristics based on confidence. For this implementation, we'll keep it as a placeholder 
    # or separate model if data allows. 
    # For now, let's focus on a robust classification model which is the primary requirement.
    # We will add a severity output if we have labeled tokens, otherwise we process severity via Grad-CAM area post-processing in the App.
    
    # For simplicity and robustness in the first iteration, we return a single-output model for classification.
    # Severity will be calculated in the app using Grad-CAM heatmap coverage.
    model = Model(inputs=base_model.input, outputs=class_output)
    
    return model

def train(data_dir, num_classes):
    print(f"Loading data from {data_dir}...")

    # Data Augmentation
    train_datagen = ImageDataGenerator(
        rescale=1./255,
        rotation_range=20,
        width_shift_range=0.2,
        height_shift_range=0.2,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True,
        fill_mode='nearest',
        validation_split=0.2
    )

    train_generator = train_datagen.flow_from_directory(
        data_dir,
        target_size=(IMG_SIZE, IMG_SIZE),
        batch_size=BATCH_SIZE,
        class_mode='categorical',
        subset='training'
    )

    validation_generator = train_datagen.flow_from_directory(
        data_dir,
        target_size=(IMG_SIZE, IMG_SIZE),
        batch_size=BATCH_SIZE,
        class_mode='categorical',
        subset='validation'
    )

    model = create_model(num_classes)
    
    model.compile(optimizer=Adam(learning_rate=LEARNING_RATE),
                  loss='categorical_crossentropy',
                  metrics=['accuracy'])

    # Callbacks
    checkpoint = ModelCheckpoint('plant_disease_model.h5', monitor='val_accuracy', verbose=1, save_best_only=True, mode='max')
    early_stop = EarlyStopping(monitor='val_loss', patience=5, verbose=1, restore_best_weights=True)
    reduce_lr = ReduceLROnPlateau(monitor='val_loss', factor=0.2, patience=3, verbose=1, min_lr=1e-6)

    print("Starting training...")
    history = model.fit(
        train_generator,
        epochs=EPOCHS,
        validation_data=validation_generator,
        callbacks=[checkpoint, early_stop, reduce_lr]
    )
    
    # Fine-tuning: Unfreeze the top layers of the model
    print("Fine-tuning model...")
    base_model = model.layers[0] # MobileNetV2 is the first layer
    base_model.trainable = True
    
    # Fine-tune from this layer onwards
    fine_tune_at = 100 
    for layer in base_model.layers[:fine_tune_at]:
        layer.trainable = False
        
    model.compile(optimizer=Adam(learning_rate=1e-5), # Lower learning rate for fine-tuning
                  loss='categorical_crossentropy',
                  metrics=['accuracy'])
                  
    history_fine = model.fit(
        train_generator,
        epochs=10, # Few more epochs
        validation_data=validation_generator,
        callbacks=[checkpoint, early_stop, reduce_lr]
    )

    print("Training complete. Model saved as plant_disease_model.h5")
    
    # Save Class Indices for the App
    class_indices = train_generator.class_indices
    with open('labels.txt', 'w') as f:
        for class_name, index in class_indices.items():
            f.write(f"{class_name}\n") # Just write names, index is implicit line number usually
    print("Labels saved to labels.txt")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Train Plant Disease Detection Model')
    parser.add_argument('--data_dir', type=str, default='dataset', help='Path to dataset directory')
    parser.add_argument('--epochs', type=int, default=20, help='Number of epochs to train')
    parser.add_argument('--batch_size', type=int, default=32, help='Batch size for training')
    args = parser.parse_args()
    
    # Update globals
    EPOCHS = args.epochs
    BATCH_SIZE = args.batch_size

    if not os.path.exists(args.data_dir):
        print(f"Error: Dataset directory '{args.data_dir}' not found.")
        print("Please structure your dataset as: dataset/class_name/image.jpg")
        # create mock structure for user to understand
        os.makedirs(os.path.join(args.data_dir, "mock_healthy"), exist_ok=True)
        os.makedirs(os.path.join(args.data_dir, "mock_diseased"), exist_ok=True)
        print(f"Created mock directories in {args.data_dir}. Please populate with real data.")
    else:
        # Count classes
        classes = len(os.listdir(args.data_dir))
        if classes < 2:
             print(f"Need at least 2 classes, found {classes} in {args.data_dir}.")
        else:
            train(args.data_dir, classes)
