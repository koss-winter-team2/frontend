import 'package:flutter/material.dart';

import '../widgets/bottom_navbar_widget.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'record_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  String challengeName = '물 1L 마시기';
  String challengePlan = '물 열심히 마실게여';
  DateTime clearDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          const HomeScreen(),
          RecordScreen(
            challengeName: challengeName,
            challengePlan: challengePlan,
            clearDate: clearDate,
          ),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavbarWidget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
