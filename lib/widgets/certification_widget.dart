import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/challenge_state.dart';

class CertificationWidget extends StatelessWidget {
  final ChallengeState state;
  final List<XFile> photos;
  final VoidCallback onAddPhoto; // screen이 가지고 있는 함수 콜백

  const CertificationWidget({
    super.key,
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
                        const Positioned(
                          left: 45,
                          top: 65,
                          child: Text(
                            '물 1L 마시기',
                            style: TextStyle(
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
                      child: Image.asset(
                        getEggImage(),
                        height: 200,
                        width: 170,
                        fit: BoxFit.cover,
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
                    Navigator.pop(context);
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
