class ChallengeState {
  final int photoCount;

  const ChallengeState({
    required this.photoCount,
  });

  bool get isCompleted => photoCount >= 3;

  ChallengeState copyWith({
    int? photoCount,
  }) {
    return ChallengeState(
      photoCount: photoCount ?? this.photoCount,
    );
  }
}
