import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaksimsamil/models/challenge_model.dart';
import 'package:jaksimsamil/services/api_service.dart';

import '../screens/main_screen.dart';
import '../models/challenge_state.dart';

class CertificationWidget extends StatelessWidget {
  final ChallengeState state;
  final List<XFile> photos;
  final VoidCallback onAddPhoto;// screen이 가지고 있는 함수 콜백
  final ChallengeModel currentChallenge;


  const CertificationWidget({
    super.key,
    required this.currentChallenge,
    required this.state,
    required this.photos,
    required this.onAddPhoto,
  });



  String getEggImage() {
    if (state.photoCount == 0) {
      return 'assets/images/egg_1.png';
    } else if (state.photoCount == 1) {
      return 'assets/images/egg_2.png';
    } else if (state.photoCount == 2) {
      return 'assets/images/egg_3.png';
    } else {
      return 'assets/images/egg_4.png';
    }
  }

  String getCenterText() {
    if (state.photoCount == 0) {
      return '작심 1일차를 시작해볼까요?';
    } else if (state.photoCount == 1) {
      return '작심 1일차 달성!\n작심 2일차를 향해 달려볼까요?';
    } else if (state.photoCount == 2) {
      return '작심 2일차 달성!\n작심 3일차를 향해 달려볼까요?';
    } else {
      return '작심 3일차 달성!';
    }
  }

  String getBubbleText() {
    if (state.photoCount == 0) {
      return '카메라로 사진을 찍어\n목표를 인증해주세요! 📸';
    } else if (state.photoCount == 1) {
      return '잘하고 있어요! 🤗\n3일을 모두 채워보세요!';
    } else if (state.photoCount == 2) {
      return '이제 하루 남았어요!\n마지막까지 화이팅! 💪';
    } else {
      return '작심삼일 목표를 이뤘어요!\n축하해요! 🎉';
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                            'assets/images/board.png'
                        ),
                        const Positioned(
                          left: 50,
                          top: 45,
                          child: Text(
                            '오늘의 작심삼일 목표',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 45,
                          top: 65,
                          child: Text(
                            currentChallenge.plan,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: GestureDetector(   //임시로 실패한 챌린지를 만들기 위한 버튼
                        onDoubleTap: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('챌린지 포기'),
                              content: const Text('정말 포기하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('포기', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            apiService.currentChallenge = null;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('챌린지를 포기했습니다')),
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const MainScreen()),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('챌린지를 포기했습니다')),
                            );

                          }
                        },
                        child: Image.asset(
                          getEggImage(),
                          height: 200,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Text(
                      textAlign: TextAlign.center,
                      getCenterText(),
                      style: const TextStyle(
                        fontFamily: 'KERISKEDU_R',
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        final isFilled = index < photos.length;

                        return GestureDetector(
                          onTap: () {
                            if (!isFilled) {
                              onAddPhoto();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xffD9D9D9),
                              borderRadius: BorderRadius.circular(10),
                              image: isFilled
                                  ? DecorationImage(
                                image: FileImage(
                                  File(photos[index].path),
                                ),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: !isFilled
                                ? const Icon(Icons.add, color: Colors.grey)
                                : null,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        Image.asset(
                            'assets/images/speech_bubble.png'
                        ),
                        Positioned(
                          left: 60,
                          top: 100,
                          child: Text(
                            getBubbleText(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MainScreen(),
                        ),
                    );
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 28,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


