import '../models/challenge.dart';
import '../models/challenge_outcome.dart';
import '../models/code_block.dart';

class ChallengeService {
  ChallengeOutcome? evaluateSolution({
    required Challenge challenge,
    required List<CodeBlock> userBlocks,
  }) {
    final isCorrect = challenge.isCorrect(userBlocks);

    if (!isCorrect) return null;

    final blocksUsed = userBlocks.length;
    final optimalBlocks = challenge.expectedBlockOrder.length;

    return ChallengeOutcome(
      challengeId: challenge.id,
      isCorrect: true,
      blocksUsed: blocksUsed,
      optimalBlocks: optimalBlocks,
      xpGained: 50,
    );
  }
}
