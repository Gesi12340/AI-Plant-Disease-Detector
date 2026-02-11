import tensorflow as tf
from tensorflow.keras.applications import MobileNetV2
from tensorflow.keras.layers import Dense, GlobalAveragePooling2D, Dropout
from tensorflow.keras.models import Model
import os

def create_mock_model():
    print("Creating mock model for testing...")
    # MobileNetV2 with random weights
    base_model = MobileNetV2(weights=None, include_top=False, input_shape=(224, 224, 3))
    x = base_model.output
    x = GlobalAveragePooling2D()(x)
    x = Dropout(0.5)(x)
    # 38 Classes matching PlantVillage
    class_output = Dense(38, activation='softmax', name='disease_output')(x)
    
    model = Model(inputs=base_model.input, outputs=class_output)
    
    model.save('plant_disease_model.h5')
    print("Mock model saved as plant_disease_model.h5")
    
    # Create dummy labels based on PlantVillage classes
    # We'll list generic ones if we can't read the dir, but since we verified the dir exists...
    # Let's try to read the actual directories to make the labels accurate!
    
    data_dir = "../dataset_repo/raw/color"
    if os.path.exists(data_dir):
        labels = sorted(os.listdir(data_dir))
        with open('labels.txt', 'w') as f:
            for label in labels:
                f.write(f"{label}\n")
        print(f"Saved {len(labels)} real labels from {data_dir}")
    else:
        # Fallback
        with open('labels.txt', 'w') as f:
            for i in range(38):
                f.write(f"Disease_Class_{i}\n")
        print("Saved mock labels.")

if __name__ == "__main__":
    create_mock_model()
