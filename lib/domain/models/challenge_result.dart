class ChallengeResult {
  final String challengeId;
  final bool success;
  final int attemptsUsed;
  final bool isGameOver;

  ChallengeResult({
    required this.challengeId,
    required this.success,
    required this.attemptsUsed,
    required this.isGameOver,
  });
}
