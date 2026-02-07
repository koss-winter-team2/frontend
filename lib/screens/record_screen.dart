import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:three_day/widgets/Challenge_complete_card.dart';
import 'package:three_day/widgets/failed_challenge_card_widget.dart';

class RecordScreen extends StatefulWidget {
  final String challengeName;
  final String challengePlan;
  final DateTime clearDate;

  const RecordScreen({
    super.key,
    required this.challengeName,
    required this.challengePlan,
    required this.clearDate,
  });

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFFD9EAFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: 5, //리스트 길이로 넣기
                itemBuilder: (context, index) {
                  //완료 챌린지 리스트받아서 넣기
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: ChallengeCompleteCard(
                      challengeName: widget.challengeName,
                      challengePlan: widget.challengePlan,
                      clearDate: widget.clearDate,
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
                decoration: BoxDecoration(
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
                      child: ListView.builder(controller: scrollController,itemCount:10 + 1 , itemBuilder: (context, index) {

                        if(index == 0){
                          return  Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2)
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16,bottom: 15),
                                  child: Text('미완수 챌린지 목록',style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900
                                  ),),
                                ),
                              ),
                            ],
                          );
                        }

                        return Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                            child: FailedChallengeCardWidget(
                              challengeName: widget.challengeName,
                              challengePlan: widget.challengePlan,
                              clearDate: widget.clearDate,
                              challengeState: null,
                            ),
                          ),
                        );
                      },),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      );

  }
}
