class ChallengeOutcome {
  final String challengeId;

  final bool isCorrect;

  final int blocksUsed;
  final int optimalBlocks;

  final int xpGained;

  ChallengeOutcome({
    required this.challengeId,
    required this.isCorrect,
    required this.blocksUsed,
    required this.optimalBlocks,
    required this.xpGained,
  });


  double get efficiency =>
      optimalBlocks / blocksUsed.clamp(optimalBlocks, 999);

  int get starRating {
    if (efficiency >= 1) return 3;
    if (efficiency >= 0.8) return 2;
    return 1;
  }
}
