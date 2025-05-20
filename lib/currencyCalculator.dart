import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/cgpaCalculator.dart';
import 'package:project/otherCalculations.dart';
import 'package:project/scientificCalculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/simpleCalculator.dart';
import 'package:project/currencyHistory.dart';
import 'package:project/globalVariable.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
 // bool isDarkMode = false;
  String fromCurrency = "USD";
  String toCurrency = "EUR";
  double rate = 0.0;
  double total = 0.0;
  TextEditingController amountController = TextEditingController();
  List<String> currencies = [];

  @override
  void initState() {
    super.initState();
    _getCurrencies();
    // Fetch exchange rates from an API here (e.g., using a service like Fixer.io)
    // For this example, we'll use a dummy rate
    // rate = 0.85; // Example rate: 1 USD = 0.85 EUR
  }

  Future<void> _getCurrencies() async {
    var response = await http
        .get(Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'));
    var data = json.decode(response.body);
    setState(() {
      currencies = (data['rates'] as Map<String, dynamic>).keys.toList();
      rate = data['rates'][toCurrency];
    });
  }

  Future<void> _getRate() async {
    var response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'));
    var data = json.decode(response.body);
    setState(() {
      rate = data['rates'][toCurrency];
    });
  }

  void _swapCurrencies() {
    setState(() {
      String temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
      _getRate();
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveConversionToFirestore() async {
    try {
      final historyCollection = _firestore
          .collection('Calculators')
          .doc('Currency')
          .collection('Results');

      await historyCollection.add({
        'fromCurrency': fromCurrency,
        'toCurrency': toCurrency,
        'rate': rate,
        'amount': double.tryParse(amountController.text) ?? 0.0,
        'total': total,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conversion saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save conversion: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: isDarkMode ? const Color(0xFF1d2630) : Colors.white,
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
                'Currency History',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyHistoryPage(),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Image(
                      image: NetworkImage(
                        'https://m.media-amazon.com/images/I/510WmeXkLXL.png',
                      ),
                    )

                    /*Image.asset(
                    'images/img1.jpg', // Replace with the actual image path
                    width: MediaQuery.of(context).size.width / 2,
                  ),*/
                    ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Color(0xFF2A2A2A),
                  ),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != '') {
                      setState(() {
                        double amount = double.parse(value);
                        total = amount * rate;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: DropdownButton<String>(
                          value: fromCurrency,
                          isExpanded: true,
                          dropdownColor: isDarkMode? Color(0xFF1d2630) : Colors.white,
                          style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : Color(0xFF1d2630)),
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              fromCurrency = newValue!;
                              _getRate();
                            });
                          }),
                    ),
                    IconButton(
                        onPressed: _swapCurrencies,
                        icon: Icon(Icons.swap_horiz,
                            size: 40,
                            color:
                                isDarkMode ? Colors.white : Color(0xFF1d2630))),
                    SizedBox(
                      width: 100,
                      child: DropdownButton<String>(
                          value: toCurrency,
                          isExpanded: true,
                          dropdownColor: isDarkMode? Color(0xFF1d2630) : Colors.white,
                          style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white
                                  : Color(0xFF1d2630)),
                          items: currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              toCurrency = newValue!;
                              _getRate();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Rate $rate",
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.white : Color(0xFF1d2630),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '${total.toStringAsFixed(3)}',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(

                onPressed: () {
                  if (amountController.text.isNotEmpty && rate > 0) {
                    _saveConversionToFirestore();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Please enter a valid amount and try again.')),
                    );
                  }
                },
                child: Text('Save to History'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: isDarkMode? Color(0xFF1d2630) : Colors.white,
                  ),

                ),


            ],
          ),
        ),
      ),
    );
  }
}
