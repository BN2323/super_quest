import 'code_block.dart';

class Challenge {
  final String id;
  final String description;
  final List<CodeBlock> availableBlocks;
  final List<String> expectedBlockOrder;
  final int maxAttempts;

  Challenge({
    required this.id,
    required this.description,
    required this.availableBlocks,
    required this.expectedBlockOrder,
    required this.maxAttempts,
  });
}
