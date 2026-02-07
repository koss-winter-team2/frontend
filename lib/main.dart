import 'package:flutter/material.dart';

import 'screens/intro_screen.dart';

void main() {
  runApp(const JakSimSamIl());
}

class JakSimSamIl extends StatelessWidget {
  const JakSimSamIl({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}
