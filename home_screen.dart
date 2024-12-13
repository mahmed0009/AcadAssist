import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 160, 16),
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Center(child: Text('Currency Converter')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset(
                    'images/img1.jpg', // Replace with the actual image path
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
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
                          dropdownColor: Color(0xFF1d2630),
                          style: TextStyle(color: Colors.white),
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
                            size: 40, color: Colors.white)),
                    SizedBox(
                      width: 100,
                      child: DropdownButton<String>(
                          value: toCurrency,
                          isExpanded: true,
                          dropdownColor: Color(0xFF1d2630),
                          style: TextStyle(color: Colors.white),
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
                  color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
