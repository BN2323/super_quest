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
  final List<CodeBlock> availableBlocks;
  final List<String> expectedBlockOrder;
  final int maxAttempts; // ✅ ADD THIS

  Challenge({
    required this.id,
    required this.type,
    required this.description,
    required this.availableBlocks,
    required this.expectedBlockOrder,
    required this.maxAttempts,
  });
}
