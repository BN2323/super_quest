import 'code_block.dart';

enum ChallengeType {
  blockAssembly,
}

class Challenge {
  final String id;
  final ChallengeType type;
  final String description;

  final List<CodeBlock> availableBlocks;
  final List<String> expectedBlockOrder;
  final int maxAttempts;

  Challenge({
    required this.id,
    required this.type,
    required this.description,
    required this.availableBlocks,
    required this.expectedBlockOrder,
    required this.maxAttempts,
  });

  bool isCorrect(List<CodeBlock> userBlocks) {
    if (userBlocks.length != expectedBlockOrder.length) return false;

    for (int i = 0; i < expectedBlockOrder.length; i++) {
      if (userBlocks[i].id != expectedBlockOrder[i]) return false;
    }
    return true;
  }
}
