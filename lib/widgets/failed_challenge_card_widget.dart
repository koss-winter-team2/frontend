import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/challenge_state.dart';

class FailedChallengeCardWidget extends StatefulWidget {
  final String challengeName;
  final String challengePlan;
  final DateTime clearDate;
  final ChallengeState? challengeState;

  const FailedChallengeCardWidget({
    super.key,
    required this.challengeState,
    required this.challengeName,
    required this.challengePlan,
    required this.clearDate,
  });

  @override
  State<FailedChallengeCardWidget> createState() =>
      _FailedChallengeCardWidgetState();
}

class _FailedChallengeCardWidgetState extends State<FailedChallengeCardWidget> {
  late final String year = widget.clearDate.year.toString();
  late final String month = widget.clearDate.month.toString().padLeft(2, '0');
  late String day = widget.clearDate.day.toString().padLeft(2, '0');

  late String date = '$year.$month.$day';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 160,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFFF6F7FC),
      ),
      // 구분용 색
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.challengeName,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                height: 25,
                child: Center(
                  child: Text(
                    widget.challengePlan,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9EAFF),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  //삭제 로직 넣기
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC8C8C8)
                  ),
                  child: Image.asset('assets/images/trash.png')
                ),
              )
            ],
          ),
          SizedBox(height: 20),
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC8C8C8),
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
              SizedBox(width: 2),
              Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC8C8C8),
                  ),
                ),
              ),
              SizedBox(width: 2),
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFFC8C8C8),
                ),
              ),
              SizedBox(width: 3,),
              for(int i =0; i<4; i++) Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC8C8C8),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Center(
                child: GestureDetector(
                  onTap: () {
                    
                    //재시작 로직
                    
                  },
                  child: Container(
                    width: 62,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Color(0xFF358CFF),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Image.asset('assets/images/retry.png'),
                    ),
                  ),
                ),
              )

            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(date, style: TextStyle(fontFamily: 'Pretendard', fontSize: 12),),
            ),
          ),
        ],
      ),
    );
  }
}
