import 'package:flutter/material.dart';

import 'screens/intro_screen.dart';

void main() {
  runApp(const JakSimSamIl());
}

class JakSimSamIl extends StatelessWidget {
  const JakSimSamIl({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
      theme: ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
