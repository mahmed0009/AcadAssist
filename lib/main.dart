// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, library_private_types_in_public_api, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/simpleCalculator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDaDEdTWkI0HdiVB69sVwztJJyZ2gHpzgM",
            authDomain: "accadassist-5742d.firebaseapp.com",
            projectId: "accadassist-5742d",
            storageBucket: "accadassist-5742d.firebasestorage.app",
            messagingSenderId: "905978019454",
            appId: "1:905978019454:web:c86efdd0b42d9845e1e22f",
            measurementId: "G-QYYN9T39JS"));
  } else {
    await Firebase.initializeApp();
  }
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
