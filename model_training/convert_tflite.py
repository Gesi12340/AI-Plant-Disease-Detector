import tensorflow as tf
import argparse
import os

def convert_to_tflite(model_path, output_path):
    if not os.path.exists(model_path):
        print(f"Error: Model file '{model_path}' not found.")
        return

    print(f"Loading model from {model_path}...")
    model = tf.keras.models.load_model(model_path)

    print("Converting to TFLite...")
    converter = tf.lite.TFLiteConverter.from_keras_model(model)
    
    # Optimization for size and latency
    converter.optimizations = [tf.lite.Optimize.DEFAULT]
    
    tflite_model = converter.convert()

    with open(output_path, 'wb') as f:
        f.write(tflite_model)
    
    print(f"TFLite model saved to {output_path}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Convert Keras model to TFLite')
    parser.add_argument('--model', type=str, default='plant_disease_model.h5', help='Path to .h5 model file')
    parser.add_argument('--output', type=str, default='model.tflite', help='Path for output .tflite file')
    
    args = parser.parse_args()
    convert_to_tflite(args.model, args.output)
