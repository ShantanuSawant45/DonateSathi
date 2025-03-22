import 'package:flutter/material.dart';
import 'package:web_project/screens/home_page.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donate Sathi',
      debugShowCheckedModeBanner: false,


      home: const HomePage(),
    );
  }
}


