import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/certification_widget.dart';
import '../../models/challenge_state.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({super.key});

  @override
  State<CertificationScreen> createState() => _CertificationScreen1State();
}

class _CertificationScreen1State extends State<CertificationScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CertificationWidget(
            state: state,
            photos: photos,
            onAddPhoto: addPhoto,
          ),
        ),
      ],
    );
  }
}
