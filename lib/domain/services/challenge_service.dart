import '../models/challenge.dart';
import '../models/challenge_result.dart';
import '../models/code_block.dart';

class ChallengeService {
  /// Evaluates a user's block assembly solution.
  ChallengeResult evaluate({
    required Challenge challenge,
    required List<CodeBlock> userBlocks,
    required int attemptNumber,
  }) {
    final userOrder = userBlocks.map((b) => b.id).toList();
    final expectedOrder = challenge.expectedBlockOrder;

    final isCorrect = _isOrderCorrect(
      expected: expectedOrder,
      actual: userOrder,
    );

    final isGameOver =
        !isCorrect && attemptNumber >= challenge.maxAttempts;

    return ChallengeResult(
      challengeId: challenge.id,
      success: isCorrect,
      attemptsUsed: attemptNumber,
      isGameOver: isGameOver,
    );
  }

  /// Checks if the user's block order matches the expected solution.
  bool _isOrderCorrect({
    required List<String> expected,
    required List<String> actual,
  }) {
    if (expected.length != actual.length) return false;

    for (int i = 0; i < expected.length; i++) {
      if (expected[i] != actual[i]) return false;
    }
    return true;
  }
}
