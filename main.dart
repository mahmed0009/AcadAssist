// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, library_private_types_in_public_api, non_constant_identifier_names

import 'package:accadassist/simpleCalculatorLightTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AccadAssist',
      home: SimpleCalculator(),
    );
  }
}
