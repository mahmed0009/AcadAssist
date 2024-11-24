// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  _SimpleCalculatorState createState() {
    return _SimpleCalculatorState();
  }
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String TextToDisplay = '';
  String Ans = '0';

  //I have created this funtion to update the diplay, So the user can see which key has he pressed.
  void updateDisplay(String buttonValue) {
    setState(() {
      TextToDisplay += buttonValue;
    });
  }

// Function to calculate the Answer of the data stored in the TextToDisplay variable.
  void calculateAnswer() {
    try {
      // Replace 'x' with '*' for multiplication
      String expression = TextToDisplay.replaceAll('x', '*');

      // Break the expression into parts (numbers and operators)
      List<String> parts = expression.split(RegExp(r'(?<=[-+*/])|(?=[-+*/])'));

      // Start evaluating from left to right
      double result = double.parse(parts[0]); // First number

      for (int i = 1; i < parts.length; i += 2) {
        String operator = parts[i]; // Get the operator
        double nextNumber = double.parse(parts[i + 1]); // Get the next number

        // Perform operation based on the operator
        if (operator == '+') {
          result += nextNumber;
        } else if (operator == '-') {
          result -= nextNumber;
        } else if (operator == '*') {
          result *= nextNumber;
        } else if (operator == '/') {
          result /= nextNumber;
        }
      }

      // Update the result in the UI
      setState(() {
        Ans = result.toString();
      });
    } catch (e) {
      // Show "Error" if the calculation fails
      setState(() {
        Ans = "Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2A2A),
        title: Text(
          'Simple Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  'AccadAssist',
                  style: TextStyle(
                    color: Color(0xFF2A2A2A),
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
                  color: Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {},
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
                  color: Color(0xFF2A2A2A),
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.calculate,
                color: Color(0xFFFF9500),
                size: 30,
              ),
              title: Text(
                'CGPA Calculator',
                style: TextStyle(
                  color: Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // This container will show the user input
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 1,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                right: 8,
              ),
              child: Text(
                TextToDisplay,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
            ),
          ),

          // This container will show the answer
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 1,
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: Text(
                Ans,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Color(0xFFFF9500),
                  fontSize: 65,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(33),
                  topRight: Radius.circular(33),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'AC',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              //This will clear the text
                              TextToDisplay = '';
                              Ans = '0';
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              child: Icon(
                                Icons.cancel,
                                size: 40,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              // this will delete the last character
                              TextToDisplay = TextToDisplay.substring(
                                  0, TextToDisplay.length - 1);
                            });
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('%');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '/',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('/');
                          },
                        ),
                      ],
                    ),
                    // Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '7',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('7');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '8',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('8');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '9',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('9');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                'x',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('x');
                          },
                        ),
                      ],
                    ),
                    // Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('4');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('5');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '6',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('6');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('-');
                          },
                        ),
                      ],
                    ),
                    // Row 4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('1');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('2');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('3');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('+');
                          },
                        ),
                      ],
                    ),
                    // Row 5
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Container(
                            width: 155,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '0          ',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('0');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFF505050),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '.',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            updateDisplay('.');
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9500),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '=',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            calculateAnswer();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
