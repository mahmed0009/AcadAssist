import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/discountHistory.dart';
import 'package:project/cgpaCalculator.dart';
import 'package:project/otherCalculations.dart';
import 'package:project/scientificCalculator.dart';
import 'package:project/simpleCalculator.dart';
import 'package:project/globalVariable.dart';

class DiscountCalculator extends StatefulWidget {
  const DiscountCalculator({super.key});

  @override
  DiscountCalculatorState createState() {
    return DiscountCalculatorState();
  }
}

class DiscountCalculatorState extends State<DiscountCalculator> {
  //bool isDarkMode = false;
  TextEditingController orignalAmount = TextEditingController();
  TextEditingController discount = TextEditingController();

  double discountedAmount = 0,
      convertDiscount = 0,
      ammountAfterDiscountApplied = 0;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void calculateAndStoreDiscount() async {
    try {
      setState(() {
        convertDiscount = double.parse(discount.text) / 100;
        discountedAmount = double.parse(orignalAmount.text) * convertDiscount;
        ammountAfterDiscountApplied =
            double.parse(orignalAmount.text) - discountedAmount;
      });

      // Store the results in Firestore
      await _firestore
          .collection('Calculators')
          .doc('Discount')
          .collection('Results')
          .add({
        'originalAmount': double.parse(orignalAmount.text),
        'discountPercentage': double.parse(discount.text),
        'discountedAmount': discountedAmount,
        'finalAmount': ammountAfterDiscountApplied,
        'timestamp': Timestamp.now(),
      });

      // Notify user on successful save
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Calculation saved to Firestore!')),
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
          'Discount Calculator',
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
                'Discount History',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryPage(),
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
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Orignal Ammount',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            TextField(
              controller: orignalAmount,
              cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
              decoration: InputDecoration(
                hintText: ' 0.00',
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
                      color: isDarkMode ? Colors.white : Color(0xFF514D4D),
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Discount %',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            TextField(
              controller: discount,
              cursorColor: isDarkMode ? Color(0xFF514D4D) : Colors.white,
              decoration: InputDecoration(
                hintText: ' 0%',
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
                      color: isDarkMode ? Colors.white : Color(0xFF514D4D),
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 1,
              color: Colors.transparent,
              child: Text(
                'Discounted ammount : ' +
                    discountedAmount.toString() +
                    '\nAmmount after discount applied : ' +
                    ammountAfterDiscountApplied.toString(),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(160, 60),
                ),
                onPressed: () {
                  if (orignalAmount.text != Null && discount.text != Null) {
                    calculateAndStoreDiscount();
                  }
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
