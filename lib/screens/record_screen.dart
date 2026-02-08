import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../models/challenge_model.dart';
import '../widgets/challenge_complete_card.dart';
import '../widgets/failed_challenge_card_widget.dart';

class RecordScreen extends StatefulWidget {

  const RecordScreen({
    super.key,
  });

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen>{
  ApiService apiService = ApiService();
  bool isLoading = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadChallenges();
  }

  Future<void> loadChallenges() async {
    setState(() {
      isLoading = true;
    });

    try {
      await apiService.getChallenges();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('에러: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ChallengeModel> completedChallenges = apiService.challenges.where((element) => element.isComplete,).toList();
    List<ChallengeModel> failedChallenges = apiService.challenges.where((element) => !element.isComplete && element.challengeId != apiService.currentChallenge?.challengeId ,).toList();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadChallenges,
        child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF_D9_EA_FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: completedChallenges.length, //리스트 길이로 넣기
                    itemBuilder: (context, index) {
                      //완료 챌린지 리스트받아서 넣기
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: ChallengeCompleteCard(
                          challengeModel: completedChallenges[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, -2),
                        ),
                      ],
                      color: Color(0xFF358CFF),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      children: [

                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount:failedChallenges.length + 1,
                            itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                    width: 40,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(2)
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20, bottom: 15),
                                      child: Text('미완수 챌린지 목록',
                                        style: TextStyle(
                                          fontFamily: 'Pretendard',
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            return Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                                child: FailedChallengeCardWidget(
                                  challengeModel: failedChallenges[index-1],
                                    onDelete: () { }
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
      ),
    );
  }
}
