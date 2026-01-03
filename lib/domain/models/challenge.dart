import 'package:super_quest/domain/models/code_block.dart';

enum ChallengeType {
  blockAssembly,
  codeReading,
  debug,
  decision,
}

class Challenge {
  final String id;
  final ChallengeType type;
  final String description;

  // Blocks the player can use
  final List<CodeBlock> availableBlocks;

  // Expected correct solution (block order)
  final List<String> expectedBlockSequence;

  Challenge({
    required this.id,
    required this.type,
    required this.description,
    required this.availableBlocks,
    required this.expectedBlockSequence,
  });
}
