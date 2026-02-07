import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallengeCompleteCard extends StatefulWidget {
  final String challengeName;
  final String challengePlan;
  final DateTime clearDate;

  const ChallengeCompleteCard({
    super.key,
    required this.challengeName,
    required this.challengePlan,
    required this.clearDate,
  });

  @override
  State<ChallengeCompleteCard> createState() => _ChallengeCompleteCardState();
}

class _ChallengeCompleteCardState extends State<ChallengeCompleteCard> {
  final List<File?> _imageList = []; // 받아온 이미지?
  late final String year = widget.clearDate.year.toString();
  late final String month = widget.clearDate.month.toString().padLeft(2, '0');
  late String day = widget.clearDate.day.toString().padLeft(2, '0');

  late String date = '$year.$month.$day';


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 160,
      padding: EdgeInsets.all(10),
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
                  widget.challengeName,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                height: 25,
                child: Center(
                  child: Text(
                    widget.challengePlan,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFD9EAFF),
                  borderRadius: BorderRadius.circular(15),
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
              SizedBox(width: 2),
              Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
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
             SizedBox(width: 10,),
              Column(
                children: [
                  SizedBox(height: 21,),
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
              child: Text(date, style: TextStyle(fontFamily: 'Pretendard', fontSize: 12),),
            ),
          ),
        ],
      ),
    );
  }
}
