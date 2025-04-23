import 'package:flutter/material.dart';
import 'package:web_project/screens/home_page.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donate Sathi',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}


