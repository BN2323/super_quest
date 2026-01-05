import '../models/challenge.dart';
import '../models/challenge_result.dart';
import '../models/code_block.dart';

class ChallengeService {
  ChallengeResult submitAttempt({
    required Challenge challenge,
    required List<CodeBlock> userBlocks,
    required int attemptNumber,
  }) {
    final bool success = challenge.isCorrect(userBlocks);
    final bool isGameOver =
        !success && attemptNumber >= challenge.maxAttempts;

    return ChallengeResult(
      challengeId: challenge.id,
      success: success,
      attemptsUsed: attemptNumber,
      isGameOver: isGameOver,
    );
  }
}
