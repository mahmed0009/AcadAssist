import 'package:flutter/material.dart';
import 'package:project/bmiCalculator.dart';
import 'package:project/currencyCalculator.dart';
import 'package:project/discountCalculator.dart';
import 'package:project/scientificCalculator.dart';
import 'package:project/simpleCalculator.dart';
import 'package:project/globalVariable.dart';
import 'cgpaCalculator.dart';

class OtherCalculators extends StatefulWidget {
  const OtherCalculators({super.key});

  @override
  OtherCalculatorsState createState() {
    return OtherCalculatorsState();
  }
}

class OtherCalculatorsState extends State<OtherCalculators> {
  //bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Other Calculator',
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
        padding: EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
          bottom: 10,
        ),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.monitor_heart,
                size: 32,
                color: Color(0xFF4CAF50),
              ),
              title: Text(
                'BMI Calculator',
                style: TextStyle(
                  color: isDarkMode? Colors.white: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BMICalculator(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.currency_exchange,
                size: 32,
                color: Color(0xFFFFD700),
              ),
              title: Text(
                'Currency Converter',
                style: TextStyle(
                  color: isDarkMode? Colors.white: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyConverter(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.discount,
                size: 32,
                color: Colors.orange,
              ),
              title: Text(
                'Discount Calculator',
                style: TextStyle(
                  color: isDarkMode? Colors.white: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiscountCalculator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
