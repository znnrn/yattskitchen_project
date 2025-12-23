import 'package:flutter/material.dart';
import 'FoodMenuScreen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yatt's Kitchen UI",
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.amber, 
        primaryColor: const Color(0xFFFFCC33),
        scaffoldBackgroundColor: const Color(0xFFFFF9F0), 
        fontFamily: 'Montserrat',
      ),
      home: const FoodMenuScreen(), 
    );
  }
}