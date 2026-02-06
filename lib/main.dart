import 'package:flutter/material.dart';
import 'package:three_day/home_screen.dart';
import 'package:three_day/main_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //fontFamily: 'Pretendard',
      ),
      home: Scaffold(
        body: SafeArea(
          child: MainScreens(),
        ),
      ),
    );
  }
}

