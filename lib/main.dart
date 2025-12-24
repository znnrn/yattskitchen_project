import 'package:flutter/material.dart';
import 'splashscreen.dart'; // Ensure this filename matches exactly

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yatt's Kitchen",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      // This tells Flutter to open the Splash Screen first
      home: const SplashScreen(), 
    );
  }
}