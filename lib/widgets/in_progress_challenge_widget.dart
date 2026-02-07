import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/challenge_state.dart';

class InProgressChallengeWidget extends StatefulWidget {
  final String challengeName;
  final String challengePlan;
  final DateTime startDate;
  final ChallengeState? challengeState;

  const InProgressChallengeWidget({
    super.key,
    required this.challengeState,
    required this.startDate,
    required this.challengePlan,
    required this.challengeName,
  });

  @override
  State<InProgressChallengeWidget> createState() =>
      _InProgressChallengeWidgetState();
}

class _InProgressChallengeWidgetState extends State<InProgressChallengeWidget> {
  late final String year = widget.startDate.year.toString();
  late final String month = widget.startDate.month.toString().padLeft(2, '0');
  late String day = widget.startDate.day.toString().padLeft(2, '0');

  late String date = '$year.$month.$day';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 348,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          left: 16,
          bottom: 16,
          top: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.challengeName,
                  style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Pretendard'
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                    child: Divider(
                        color: Colors.black,
                        thickness: 1
                    ),
                ),
                const SizedBox(width: 10),
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF9E9E9E),
                    fontSize: 15,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 2),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6EEF7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Text(
                            widget.challengePlan,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                          '진행 현황',
                          style: TextStyle(fontSize: 25)
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 130,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6EEF7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 95,
                                height: 95,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/water.jpg', // 첫날 사진
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFC8C8C8),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3),
                              Container(
                                width: 95,
                                height: 95,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/images/water.jpg', // 2일차 사진
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Center(
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFC8C8C8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Container(
                                width: 95,
                                height: 95,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC8C8C8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},

                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color(0xFF358CFF),
                        ),
                        child: const Text(
                          '인증하러 가기',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
