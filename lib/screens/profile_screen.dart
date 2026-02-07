import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(color: Color(0xFFD9EAFF)),
              padding: const EdgeInsets.all(15),
              height: 96,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '김코스',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 25,
                              ),
                            ),
                            Container(
                              width: 54,
                              height: 24,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFF979797)),
                              ),
                              child: const Center(
                                child: Text(
                                  '로그아웃',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF979797),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Positioned(
                    right: 0,
                    bottom: 0,
                    child: Text(
                      '2026.02.07',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '내 계정',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  color: Color(0xFF838383),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'koss@kookmin.ac.kr',
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  color: Color(0xFF838383),
                ),
              ),
            ),
            const SizedBox(height: 7,),
            const Divider(
                color: Color(0xFFD1D5DA),
                thickness: 1,
                height: 5
            ),
          ],
        ),
      ),
    );
  }
}
