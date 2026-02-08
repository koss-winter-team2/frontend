class ChallengeModel {
  final String challengeId;
  final String title;
  final String plan;
  final List<bool> days;
  final int currentDay;
  final bool isComplete;
  final DateTime createdAt;

  const ChallengeModel({
    required this.challengeId,
    required this.title,
    required this.plan,
    required this.days,
    required this.currentDay,
    required this.isComplete,
    required this.createdAt,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json){
    return ChallengeModel(
        challengeId: json['challengeId'],
        title: json['title'],
        plan: json['plan'],
        days: (json['days'] as List<dynamic>)
            .map((e) => e as bool)
            .toList(),
        currentDay: json['currentDay'],
        isComplete: json['isComplete'],
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'])
            : DateTime.now());
  }

  Map<String, dynamic> toJson() {
    return {
      'challengeId': this.challengeId,
      'title': this.title,
      'plan': this.plan,
      'days': this.days,
      'currentDay': this.currentDay,
      'isComplete': this.isComplete,
      'createdAt': createdAt.toIso8601String()
    };
  }

}