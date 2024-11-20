# app.py

from flask import Flask, request, jsonify
import joblib
import numpy as np

# Load the pre-trained model (make sure to replace the path with your actual model path)
model = joblib.load('random_forest_model.pkl')

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    # Get JSON data from request
    data = request.get_json()
    
    # Assuming the input data is in the right order and format
    # Convert input data into a 2D array for model prediction
    input_data = np.array([[
        data['age'],
        data['hypertension'],
        data['heart_disease'],
        data['avg_glucose_level'],
        data['bmi'],
        data['gender'],
        data['ever_married'],
        data['work_type'],
        data['Residence_type'],
        data['smoking_status'],
        data['has_diabetes'],
        data['is_obese']
    ]])
    
    # Predict using the loaded model
    prediction = model.predict(input_data)
    
    # Return the prediction as a JSON response
    result = {
        'prediction': int(prediction[0])
    }
    return jsonify(result)

if __name__ == '__main__':
    app.run(debug=True)
