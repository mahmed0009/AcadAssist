import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/cgpaCalculator.dart';
import 'package:project/otherCalculations.dart';
import 'package:project/scientificCalculator.dart';
import 'package:project/simpleCalculator.dart';
import 'package:project/globalVariable.dart';

class CgpaHistoryPage extends StatefulWidget {
  const CgpaHistoryPage({super.key});

  @override
  CgpaHistoryPageState createState() {
    return CgpaHistoryPageState();
  }
}

class CgpaHistoryPageState extends State<CgpaHistoryPage> {
  //bool isDarkMode = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'CGPA History',
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
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('Calculators')
              .doc('Cgpa')
              .collection('Results')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No CGPA history available',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 18,
                  ),
                ),
              );
            }

            final historyData = snapshot.data!.docs;

            return ListView.builder(
              itemCount: historyData.length,
              itemBuilder: (context, index) {
                final item = historyData[index];

                // Retrieve CGPA history data
                final cgpa = item['calculatedCGPA'];
                final timestamp = (item['timestamp'] as Timestamp).toDate();

                return Card(
                  color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                  child: ListTile(
                    title: Text(
                      'CGPA: $cgpa',
                      style: TextStyle(
                        color:
                            isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                      ),
                    ),
                    subtitle: Text(
                      'Date: ${timestamp.toLocal()}',
                      style: TextStyle(
                        color: isDarkMode
                            ? Colors.white70
                            : const Color(0xFF2A2A2A),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
