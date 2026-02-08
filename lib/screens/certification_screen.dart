import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaksimsamil/models/challenge_model.dart';
import 'package:jaksimsamil/services/api_service.dart';
import 'package:jaksimsamil/utils/logger.dart';
import '../widgets/certification_widget.dart';
import '../models/challenge_state.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({super.key});

  @override
  State<CertificationScreen> createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {

  ApiService _apiService = ApiService();

  ChallengeState state = const ChallengeState(
    photoCount: 0,
  );



  final ImagePicker _picker = ImagePicker();
  final List<XFile> photos = [];

  Future<void> addPhoto() async {
    if (photos.length >= 3) return;

    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image == null) return;

    setState(() {
      photos.add(image);
      state = state.copyWith(photoCount: photos.length);
    });

    _apiService.uploadProof(challengeId: _apiService.currentChallenge!.challengeId, dayIndex: photos.length-1, imageFile: File(image.path));
    logger.d('사진 업데이트 성공 ${photos.length-1}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CertificationWidget(
            currentChallenge: _apiService.currentChallenge!,
            state: state,
            photos: photos,
            onAddPhoto: addPhoto,
          ),
        ),
      ],
    );
  }
}
