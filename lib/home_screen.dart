import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28.46),
          Text(
            '사용자님, 안녕하세요!',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          ),
          Text(
            '오늘도 작심삼일을 향해 달려볼까요?',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 23),
          ),
          SizedBox(height: 28.54),
          Container(
            width: double.infinity,
            height: 40.17,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '진행중인 챌린지',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 348,
            decoration: BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                '현재 진행중인 챌린지가 없어요.. \n신규 챌린지를 생성하여, 도전해보세요!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 102,
                  height: 97,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAF3FE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Color(0xFF4B4B4B),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () => AlertDialog(),
                        child: Icon(Icons.add, color: Colors.white, size: 13),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 32),
                Center(
                  child: Text('신규 챌린지 생성', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
