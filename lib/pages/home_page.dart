import 'dart:convert';
import 'package:predstroke/components/bottom_nav_bar.dart';
import 'package:predstroke/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:predstroke/services/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void signOut() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  final TextEditingController ageController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();

  // Dropdown selections
  int gender = 0;
  int hypertension = 0;
  int heartDisease = 0;
  int everMarried = 0;
  int workType = 0;
  int residenceType = 0;
  int smokingStatus = 0;
  int hasDiabetes = 0;
  int isObese = 0;

  String result = '';

  Future<void> predictStroke() async {
    // Collect the data and format it as JSON
    final inputData = {
      'age': double.tryParse(ageController.text) ?? 0.0,
      'hypertension': hypertension,
      'heart_disease': heartDisease,
      'avg_glucose_level': double.tryParse(glucoseController.text) ?? 0.0,
      'bmi': double.tryParse(bmiController.text) ?? 0.0,
      'gender': gender,
      'ever_married': everMarried,
      'work_type': workType,
      'Residence_type': residenceType,
      'smoking_status': smokingStatus,
      'has_diabetes': hasDiabetes,
      'is_obese': isObese,
    };

    // Send POST request to Flask API
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/predict'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(inputData),
    );

    // Decode response and update result
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        result = jsonResponse['prediction'] == 1
            ? "High risk of stroke"
            : "Low risk of stroke";
      });
    } else {
      setState(() {
        result = 'Error: Unable to make prediction';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Stroke Prediction",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      drawer: const Mydrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: ageController,
                        decoration: InputDecoration(
                          labelText: "Age",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown("Gender", gender, (value) {
                        setState(() => gender = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("Male")),
                        DropdownMenuItem(value: 1, child: Text("Female")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Hypertension", hypertension, (value) {
                        setState(() => hypertension = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("No")),
                        DropdownMenuItem(value: 1, child: Text("Yes")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Heart Disease", heartDisease, (value) {
                        setState(() => heartDisease = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("No")),
                        DropdownMenuItem(value: 1, child: Text("Yes")),
                      ]),
                      const SizedBox(height: 12),
                      TextField(
                        controller: glucoseController,
                        decoration: InputDecoration(
                          labelText: "Average Glucose Level",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: bmiController,
                        decoration: InputDecoration(
                          labelText: "BMI",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      _buildDropdown("Ever Married", everMarried, (value) {
                        setState(() => everMarried = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("No")),
                        DropdownMenuItem(value: 1, child: Text("Yes")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Work Type", workType, (value) {
                        setState(() => workType = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("Private")),
                        DropdownMenuItem(
                            value: 1, child: Text("Self-employed")),
                        DropdownMenuItem(value: 2, child: Text("Govt_job")),
                        DropdownMenuItem(value: 3, child: Text("Children")),
                        DropdownMenuItem(value: 4, child: Text("Never worked")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Residence Type", residenceType, (value) {
                        setState(() => residenceType = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("Urban")),
                        DropdownMenuItem(value: 1, child: Text("Rural")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Smoking Status", smokingStatus, (value) {
                        setState(() => smokingStatus = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("Never smoked")),
                        DropdownMenuItem(
                            value: 1, child: Text("Formerly smoked")),
                        DropdownMenuItem(value: 2, child: Text("Smokes")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Has Diabetes", hasDiabetes, (value) {
                        setState(() => hasDiabetes = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("No")),
                        DropdownMenuItem(value: 1, child: Text("Yes")),
                      ]),
                      const SizedBox(height: 12),
                      _buildDropdown("Is Obese", isObese, (value) {
                        setState(() => isObese = value!);
                      }, [
                        DropdownMenuItem(value: 0, child: Text("No")),
                        DropdownMenuItem(value: 1, child: Text("Yes")),
                      ]),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: predictStroke,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            "Predict",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          result,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build Dropdown widgets
  Widget _buildDropdown(
    String label,
    int value,
    ValueChanged<int?> onChanged,
    List<DropdownMenuItem<int>> items,
  ) {
    return DropdownButtonFormField<int>(
      value: value,
      onChanged: onChanged,
      items: items,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
