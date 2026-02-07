import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:three_day/screens/home_screen.dart';
import 'package:three_day/screens/profile_screen.dart';
import 'package:three_day/screens/record_screen.dart';
import 'package:three_day/widgets/Challenge_complete_card.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({super.key});

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),

          RecordScreen(challengeName: '물마시기', challengePlan: '하루 1리터', clearDate: DateTime.now(),),
          //Center(child: ChallengeCompleteCard(challengeName: '물마시기', challengePlan: '하루 1리터', clearDate: DateTime.now(),)),

          ProfileScreen(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabController.index,
        onTap: (index) {
          tabController.animateTo(index);
          setState(() {});
        },
        selectedItemColor: Color(0xFF358CFF),
        iconSize: 35,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: 'challenge_record',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'myState'),
        ],
      ),
    );
  }
}
