import 'package:flutter/material.dart';
import 'package:three_day/screens/home_screen.dart';
import 'package:three_day/screens/main_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: MainScreens(),
        ),
      ),
    );
  }
}

