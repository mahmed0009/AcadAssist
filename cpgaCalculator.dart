// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, file_names, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, curly_braces_in_flow_control_structures, non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:project/otherCalculations.dart';
import 'package:project/scientificCalculator.dart';
import 'package:project/simpleCalculator.dart';

class CgpaCalculator extends StatefulWidget {
  const CgpaCalculator({super.key});

  @override
  _CgpaCalculatorState createState() {
    return _CgpaCalculatorState();
  }
}

class _CgpaCalculatorState extends State<CgpaCalculator> {
  bool isDarkMode = false;

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController creditHoursController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  List<String> subjects = [];
  List<double> creditHours = [];
  List<double> grade = [];

  double GPA = 0, CGPA = 0, totalCreditHours = 0;
  String GpaText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2A2A),
        title: Text(
          'CGPA Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      // This line of code will the the theme from light to dark
      backgroundColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,

      drawer: Drawer(
        backgroundColor: isDarkMode ? Color(0xFF2A2A2A) : Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'AccadAssist',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Color(0xFF2A2A2A),
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Color(0xFFFF9500),
                size: 30,
              ),
              title: Text(
                'Simple Calculator',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Color(0xFF2A2A2A),
                  fontSize: 20,
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
              leading: Icon(
                Icons.calculate,
                color: Color(0xFFFF9500),
                size: 30,
              ),
              title: Text(
                'Scientific Calculator',
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Color(0xFF2A2A2A),
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
              leading: Icon(
                Icons.sunny_snowing,
                color: Color(0xFFFF9500),
                size: 30,
              ),
              title: Text(
                isDarkMode ? 'Change to light theme' : 'Change to dark theme',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                setState(
                  () {
                    isDarkMode = !isDarkMode;
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.height * 1,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: subjectController,
                    cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
                    decoration: InputDecoration(
                      hintText: ' Subject',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.white : Color(0xFF514D4D),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:
                                isDarkMode ? Colors.white : Color(0xFF514D4D),
                          ),
                          borderRadius: BorderRadius.circular(100)),
                      filled: true,
                      fillColor: isDarkMode ? Colors.white : Color(0xFF514D4D),
                    ),
                    style: TextStyle(
                      color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: creditHoursController,
                    cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
                    decoration: InputDecoration(
                      hintText: ' Credit Hours',
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextField(
                    controller: gradeController,
                    cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
                    decoration: InputDecoration(
                      hintText: ' Grade',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Color(0xFFB3B3B3) : Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.height * 1,
                    color: Colors.transparent,
                    child: Text(
                      'Your CGPA is ' + GpaText,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 1,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Container(
                    width: 160,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF9500),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    GPA = 0;
                    totalCreditHours = 0;

                    // Calculate total grade points and credit hours
                    for (int i = 0; i < subjects.length; i++) {
                      GPA += grade[i] *
                          creditHours[i]; // Grade Points = Grade * Credit Hours
                      totalCreditHours += creditHours[i]; // Total Credit Hours
                    }

                    // Calculate CGPA
                    if (totalCreditHours > 0) {
                      CGPA = GPA / totalCreditHours;
                    } else {
                      CGPA = 0; // Prevent division by zero
                    }
                    setState(() {
                      GpaText = CGPA.toStringAsFixed(2); // Display rounded CGPA
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 160,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF9500),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    child: Center(
                      child: Text(
                        'Add Subject',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      // Validate credit hours input
                      if (creditHoursController.text.isEmpty ||
                          double.tryParse(creditHoursController.text) == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Please enter a valid credit hour.')),
                        );
                        return;
                      }

                      // Validate grade input
                      if (gradeController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Please enter a valid grade.')),
                        );
                        return;
                      }

                      // Add valid data to lists
                      subjects.add(subjectController.text);
                      creditHours.add(double.parse(creditHoursController.text));

                      // Grade conversion logic
                      if (gradeController.text == 'A+' ||
                          gradeController.text == 'a+')
                        grade.add(4.0);
                      else if (gradeController.text == 'A' ||
                          gradeController.text == 'a')
                        grade.add(4.0);
                      else if (gradeController.text == 'A-' ||
                          gradeController.text == 'a-')
                        grade.add(3.67);
                      else if (gradeController.text == 'B+' ||
                          gradeController.text == 'b+')
                        grade.add(3.33);
                      else if (gradeController.text == 'B' ||
                          gradeController.text == 'b')
                        grade.add(3.00);
                      else if (gradeController.text == 'B-' ||
                          gradeController.text == 'b-')
                        grade.add(2.67);
                      else if (gradeController.text == 'C+' ||
                          gradeController.text == 'c+')
                        grade.add(2.33);
                      else if (gradeController.text == 'C' ||
                          gradeController.text == 'c')
                        grade.add(2.00);
                      else if (gradeController.text == 'C-' ||
                          gradeController.text == 'c-')
                        grade.add(1.67);
                      else if (gradeController.text == 'D+' ||
                          gradeController.text == 'd+')
                        grade.add(1.33);
                      else if (gradeController.text == 'D' ||
                          gradeController.text == 'd')
                        grade.add(1.00);
                      else
                        grade.add(0.00);

                      // Clear fields for next input
                      subjectController.clear();
                      creditHoursController.clear();
                      gradeController.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
