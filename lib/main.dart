import 'screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Change the primary color
      ),
      home: WelcomeScreen(), // Set WelcomeScreen as the initial route
    );
  }
}
