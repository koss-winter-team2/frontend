class ProofModel {
  final int dayIndex;
  final String imageBase64;

  const ProofModel({
    required this.dayIndex,
    required this.imageBase64,
  });

  factory ProofModel.fromJson(Map<String, dynamic> json) {
    return ProofModel(
      dayIndex: json['dayIndex'] as int,
      imageBase64: json['imageBase64'] as String,
    );
  }

}