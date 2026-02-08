import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jaksimsamil/models/challenge_model.dart';
import 'package:jaksimsamil/models/proof_model.dart';
import 'package:jaksimsamil/services/api_service.dart';

import '../models/challenge_state.dart';
import '../screens/certification_screen.dart';
import '../utils/logger.dart';

class InProgressChallengeWidget extends StatefulWidget {
  final ChallengeModel challengeModel;

  const InProgressChallengeWidget({super.key, required this.challengeModel});

  @override
  State<InProgressChallengeWidget> createState() =>
      _InProgressChallengeWidgetState();
}

class _InProgressChallengeWidgetState extends State<InProgressChallengeWidget> {
  late final String year = widget.challengeModel.createdAt.year.toString();
  late final String month = widget.challengeModel.createdAt.month
      .toString()
      .padLeft(2, '0');
  late String day = widget.challengeModel.createdAt.day.toString().padLeft(
    2,
    '0',
  );
  bool isLoading = true;
  Map<int, ProofModel> proofsMap = {};

  ApiService apiService = ApiService();

  late ChallengeModel challengeModel = widget.challengeModel;

  late String date = '$year.$month.$day';

  void initState() {
    super.initState();
    loadAllProofs();
  }

  Future<void> loadAllProofs() async {
    setState(() => isLoading = true);
    Map<int, ProofModel> loadedProofs = {};


    try {
      for (int i = 0; i < 3; i++) {
        if (widget.challengeModel.days[i]) {
          final proof = await apiService.getUploadProof(
            id: challengeModel.challengeId,
            dayIndex: i,
          );
          if (proof != null) {
            loadedProofs[i] = proof;
          } else {
          }
        }
      }
    } catch (e) {
    }

    setState(() {
      proofsMap = loadedProofs;
      isLoading = false;
    });
  }

  Widget _buildDayImage(int dayIndex) {
    if (widget.challengeModel.days[dayIndex] && proofsMap.containsKey(dayIndex)) {
      return Container(
        width: 82,
        height: 82,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            base64Decode(proofsMap[dayIndex]!.imageBase64),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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
        child: Center(child: CircularProgressIndicator()),
      );
    }

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
                  challengeModel.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Pretendard',
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Divider(color: Colors.black, thickness: 1),
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
                            challengeModel.plan,
                            style: const TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('진행 현황', style: TextStyle(fontSize: 25)),
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
                              _buildDayImage(0),
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
                              _buildDayImage(1),
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
                              _buildDayImage(2),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CertificationScreen(),
                            ),
                          );
                        },

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
