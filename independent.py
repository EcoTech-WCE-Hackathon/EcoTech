from operator import mod
import numpy as np
import tensorflow as tf

# from tensorflow import keras
# from tensorflow.keras import layers
# from tensorflow.keras.models import Sequential
# import pathlib
import pickle
import joblib


# Load the model from the file
model = joblib.load("model.pkl")
model = pickle.loads(model)
batch_size = 32
img_height = 180
img_width = 180
class_names = ["ewaste", "not_ewaste"]
img = tf.keras.utils.load_img("./test/new1.jpeg", target_size=(img_height, img_width))
img_array = tf.keras.utils.img_to_array(img)
img_array = tf.expand_dims(img_array, 0)  # Create a batch
predictions = model.predict(img_array)
score = tf.nn.softmax(predictions[0])

print(predictions)
print(
    "This image most likely belongs to {} with a {:.2f} percent confidence.".format(
        class_names[np.argmax(score)], 100 * np.max(score)
    )
)
