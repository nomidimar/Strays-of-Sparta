import 'package:pet_match/screens/about_us.dart';
import 'package:pet_match/screens/contact_us.dart';
import 'package:pet_match/screens/donate.dart';
import 'package:pet_match/screens/next_screen.dart';
import 'package:pet_match/screens/transportations.dart';
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
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/about_us': (context) => AboutUsScreen(),
        '/adoptions': (context) => AdoptionsList(),
        '/donate': (context) => Donate(),
        '/contact': (context) => ContactUs(),
        '/transport': (context) => TransportationScreen(),
      },
    );
  }
}
