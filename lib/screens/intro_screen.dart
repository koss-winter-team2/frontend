import 'package:flutter/material.dart';
import 'package:stroke_text/stroke_text.dart';

import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff358CFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          const StrokeText(
            text: '작심삼일',
            textAlign: TextAlign.center,
            strokeColor: Color(0xff6B6B6B),
            textStyle: TextStyle(
              fontFamily: 'KERISKEDU_B',
              fontSize: 61,
              color: Color(0xffFFDD37),
            ),
          ),
        ],
      ),
    );
  }
}
