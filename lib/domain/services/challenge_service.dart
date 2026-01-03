import 'package:super_quest/domain/models/challenge.dart';
import 'package:super_quest/domain/models/challenge_result.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/room.dart';

class ChallengeService {
  Challenge getChallengeForRoom(Room room) {
    return room.challenge;
  }

  ChallengeResult submitAnswer({
    required Challenge challenge,
    required List<CodeBlock> userBlocks,
    required int attemptNumber,
  }) {
    final expected = challenge.expectedBlockOrder;
    final userOrder = userBlocks.map((b) => b.id).toList();

    final isCorrect = _compareOrder(expected, userOrder);
    final isLastAttempt = attemptNumber >= challenge.maxAttempts;

    return ChallengeResult(
      challengeId: challenge.id,
      success: isCorrect,
      attemptsUsed: attemptNumber,
      isGameOver: !isCorrect && isLastAttempt,
    );
  }

  bool _compareOrder(List<String> expected, List<String> actual) {
    if (expected.length != actual.length) return false;

    for (int i = 0; i < expected.length; i++) {
      if (expected[i] != actual[i]) return false;
    }
    return true;
  }
}
