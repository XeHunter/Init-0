# from flask import Flask, request, jsonify
# from tensorflow.keras.preprocessing import image
# import numpy as np
# import tensorflow as tf

# app = Flask(__name__)

# model = tf.keras.models.load_model("classifyWaste.h5")

# output_class = ["biodegradable", "e-waste", "medical", "recyclable-glass",
#                 "recyclable-metal", "recyclable-paper", "recyclable-plastic"]


# def waste_prediction(new_image):
#     test_image = image.load_img(new_image, target_size=(224, 224))
#     test_image = image.img_to_array(test_image) / 255
#     test_image = np.expand_dims(test_image, axis=0)
#     predicted_array = model.predict(test_image)
#     predicted_value = output_class[np.argmax(predicted_array)]
#     predicted_accuracy = round(np.max(predicted_array) * 100, 2)
#     return predicted_value, predicted_accuracy


# @app.route('/predict', methods=['POST'])
# def predict_waste():
#     if 'file' not in request.files:
#         return jsonify({'error': 'No file part'})

#     file = request.files['file']
#     if file.filename == '':
#         return jsonify({'error': 'No selected file'})

#     if file:
#         predicted_value, predicted_accuracy = waste_prediction(file)
#         return jsonify({'waste_material': predicted_value, 'accuracy': predicted_accuracy})


# if __name__ == '__main__':
#     app.run(debug=True, host='0.0.0.0', port=8050)

from flask import Flask, request, jsonify
from tensorflow.keras.preprocessing import image
import numpy as np
import tensorflow as tf
import os

app = Flask(__name__)

model = tf.keras.models.load_model("classifyWaste.h5")

output_class = ["biodegradable", "e-waste", "medical", "recyclable-glass",
                "recyclable-metal", "recyclable-paper", "recyclable-plastic"]


def waste_prediction(new_image):
    test_image = image.load_img(new_image, target_size=(224, 224))
    test_image = image.img_to_array(test_image) / 255
    test_image = np.expand_dims(test_image, axis=0)
    predicted_array = model.predict(test_image)
    predicted_value = output_class[np.argmax(predicted_array)]
    predicted_accuracy = round(np.max(predicted_array) * 100, 2)
    return predicted_value, predicted_accuracy


@app.route('/predict', methods=['POST'])
def predict_waste():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'})

    file_path = "uploaded_image.jpg"  # Save the uploaded file in the current directory
    file.save(file_path)

    predicted_value, predicted_accuracy = waste_prediction(file_path)
    os.remove(file_path)  # Remove the temporary file
    return jsonify({'waste_material': predicted_value, 'accuracy': predicted_accuracy})


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
