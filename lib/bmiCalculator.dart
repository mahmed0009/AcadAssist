import 'package:flutter/material.dart';
import 'package:project/bmiHistory.dart';
import 'package:project/cgpaCalculator.dart';
import 'package:project/otherCalculations.dart';
import 'package:project/scientificCalculator.dart';
import 'package:project/simpleCalculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/globalVariable.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  BMICalculatorState createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {
  //bool isDarkMode = false;
  bool male = true, female = false;

  // Add controllers to get input values
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String bmiResult = ""; // State variable to store the result message

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void SaveHistory() async {
    try {
      // Store the results in Firestore
      await _firestore
          .collection('Calculators')
          .doc('BMI')
          .collection('Results')
          .add({
        'Height': heightController.text,
        'Weight': weightController.text,
        'BMI Result': bmiResult,
        'timestamp': Timestamp.now(),
      });
      // Notify user on successful save
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved to Firestore!')),
      );
    } catch (e) {
      // Handle and notify the user of errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Currency Calculator',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: isDarkMode ? const Color(0xFF514D4D) : Colors.white,
      drawer: Drawer(
        backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'AccadAssist',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'Simple Calculator',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimpleCalculator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'Scientific Calculator',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScientificCalculator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'CGPA Calculator',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CgpaCalculator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'Other Calculators',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherCalculators(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                'BMI History',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BmiHistoryPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.sunny_snowing,
                  color: Color(0xFFFF9500), size: 30),
              title: Text(
                isDarkMode ? 'Change to light theme' : 'Change to dark theme',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: heightController, // Controller for height
              cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
              decoration: InputDecoration(
                hintText: 'Enter height (cm)',
                hintStyle: TextStyle(
                  color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Color(0xFF514D4D),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.white : Color(0xFF514D4D),
              ),
              style: TextStyle(
                color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              controller: weightController, // Controller for weight
              cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
              decoration: InputDecoration(
                hintText: 'Enter weight (kg)',
                hintStyle: TextStyle(
                  color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isDarkMode ? Colors.white : Color(0xFF514D4D),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.white : Color(0xFF514D4D),
              ),
              style: TextStyle(
                color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Male Card
                Card(
                  color:
                      male ? Colors.blue : Colors.grey, // Highlight if selected
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        male = true;
                        female = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.male, // Male icon
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Male",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Female Card
                Card(
                  color: female
                      ? Color(0xffff0055)
                      : Colors.grey, // Highlight if selected
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        male = false;
                        female = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.female, // Female icon
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Female",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                // Get user input
                double? height = double.tryParse(heightController.text);
                double? weight = double.tryParse(weightController.text);

                if (height != null && weight != null && height > 0) {
                  // Calculate BMI
                  double bmi = weight / ((height / 100) * (height / 100));

                  // Determine result based on BMI value
                  String genderMessage = male ? "for a male" : "for a female";
                  String result;
                  if (bmi < 18.5) {
                    result = "You are underweight $genderMessage.";
                  } else if (bmi >= 18.5 && bmi < 24.9) {
                    result = "You have a normal weight $genderMessage.";
                  } else if (bmi >= 25 && bmi < 29.9) {
                    result = "You are overweight $genderMessage.";
                  } else {
                    result = "You are obese $genderMessage.";
                  }

                  // Update state with the result
                  setState(() {
                    bmiResult =
                        "Your BMI is ${bmi.toStringAsFixed(1)}. $result";
                  });
                } else {
                  setState(() {
                    bmiResult = "Please enter valid height and weight.";
                  });
                }
                SaveHistory();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff7b00),
                padding: EdgeInsets.symmetric(horizontal: 77, vertical: 22),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              bmiResult,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
