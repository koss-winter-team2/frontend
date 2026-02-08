import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jaksimsamil/models/challenge_model.dart';

class ChallengeCompleteCard extends StatefulWidget {
  final ChallengeModel challengeModel;

  const ChallengeCompleteCard({
    super.key,
    required this.challengeModel,
  });

  @override
  State<ChallengeCompleteCard> createState() => _ChallengeCompleteCardState();
}

class _ChallengeCompleteCardState extends State<ChallengeCompleteCard> {
  late final String year = widget.challengeModel.createdAt.year.toString();
  late final String month = widget.challengeModel.createdAt.month.toString().padLeft(2, '0');
  late String day = widget.challengeModel.createdAt.day.toString().padLeft(2, '0');

  late String date = '$year.$month.$day';


  @override
  Widget build(BuildContext context) {
    final ChallengeModel challenge = widget.challengeModel;

    return Container(
      width: 320,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      // 구분용 색
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  challenge.title,
                  style: const TextStyle(fontSize: 20, fontFamily: 'Pretendard'),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFD9EAFF),
                ),
                child: Center(
                  child: Text(
                    style: const TextStyle(fontSize: 15, fontFamily: 'Pretendard'),
                    challenge.plan,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Container(
                width: 65,
                height: 65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/water.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 2),
              Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9EAFF),
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Container(
                width: 65,
                height: 65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/water.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 2),
              Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9EAFF),
                  ),
                ),
              ),
              SizedBox(width: 2),
              Container(
                width: 65,
                height: 65,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/water.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
             const SizedBox(width: 10),
              Column(
                children: [
                  const SizedBox(height: 21),
                  Container(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/egg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                date,
                style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
