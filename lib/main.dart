import 'package:pet_match/screens/about_us.dart';
import 'package:pet_match/screens/donate.dart';
import 'package:pet_match/screens/next_screen.dart';
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
      initialRoute: '/', // Define the initial route, usually '/'
      routes: {
        '/': (context) => WelcomeScreen(), // Define a route named '/'
        '/about_us': (context) => AboutUsScreen(),
        '/adoptions': (context) => AdoptionsList(),
        '/donate': (context) => Donate(),
      },
    );
  }
}
