import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaksimsamil/services/api_service.dart';

import '../models/challenge_model.dart';
import '../models/challenge_state.dart';
import '../screens/main_screen.dart';

class FailedChallengeCardWidget extends StatefulWidget {
  final ChallengeModel challengeModel;
  final VoidCallback onDelete;

  const FailedChallengeCardWidget({super.key, required this.challengeModel,required this.onDelete});

  @override
  State<FailedChallengeCardWidget> createState() =>
      _FailedChallengeCardWidgetState();
}

class _FailedChallengeCardWidgetState extends State<FailedChallengeCardWidget> {
  late final String year = widget.challengeModel.createdAt.year.toString();
  late final String month = widget.challengeModel.createdAt.month
      .toString()
      .padLeft(2, '0');
  late String day = widget.challengeModel.createdAt.day.toString().padLeft(
    2,
    '0',
  );
  ApiService apiService = ApiService();

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
        color: const Color(0xFFF6F7FC),
      ),
      // 구분용 색
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  challenge.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 5,
                ),
                height: 25,
                child: Center(
                  child: Text(
                    challenge.plan,
                    style: TextStyle(fontSize: 15, fontFamily: 'Pretendard'),
                  ),
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD9EAFF),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('삭제 확인'),
                      content: const Text('삭제하시겠습니까?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('취소'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            '삭제',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    setState(() async {
                      await apiService.deleteData(challenge.challengeId);
                      widget.onDelete();
                    });

                    //삭제로직 넣기
                  }
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFC8C8C8),
                  ),
                  child: Image.asset('assets/images/trash.png'),
                ),
              ),
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
              SizedBox(width: 3),
              for (int i = 0; i < 4; i++)
                Center(
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
              SizedBox(width: 5),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    //재시작 로직

                    if (apiService.currentChallenge != null) {

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('현재 진행중인 챌린지가 있습니다.'),
                            duration: Duration(seconds: 2),
                          ),
                        );

                        return;
                    } else {
                      apiService.resetChallenge(id: challenge.challengeId);
                      apiService.currentChallenge = await apiService.getChallengeById(challenge.challengeId);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => MainScreen()),
                      );

                      apiService.getChallenges();


                    }
                  },
                  child: Container(
                    width: 62,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Color(0xFF358CFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/retry.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                date,
                style: TextStyle(fontFamily: 'Pretendard', fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
