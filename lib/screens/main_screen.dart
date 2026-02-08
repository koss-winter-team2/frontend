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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          RecordScreen(
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
