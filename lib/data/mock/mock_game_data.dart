import 'package:super_quest/domain/models/challenge.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';

class MockGameData {
  // ===== KEYWORDS =====
  static final CodeBlock ifBlock = CodeBlock(
    id: 'if',
    type: CodeBlockType.keyword,
    label: 'if',
    value: 'if',
  );

  static final CodeBlock elseBlock = CodeBlock(
    id: 'else',
    type: CodeBlockType.keyword,
    label: 'else',
    value: 'else',
  );

  // ===== CONDITIONS =====
  static final CodeBlock conditionEven = CodeBlock(
    id: 'cond_even',
    type: CodeBlockType.condition,
    label: 'x % 2 == 0',
    value: 'x % 2 == 0',
  );

  // ===== ACTIONS =====
  static final CodeBlock returnTrue = CodeBlock(
    id: 'return_true',
    type: CodeBlockType.action,
    label: 'return true',
    value: 'true',
  );

  static final CodeBlock returnFalse = CodeBlock(
    id: 'return_false',
    type: CodeBlockType.action,
    label: 'return false',
    value: 'false',
  );


    static final Challenge challenge1 = Challenge(
    id: 'c1',
    description: 'Return true if x is even.',
    type: ChallengeType.blockAssembly,
    availableBlocks: [
      ifBlock,
      conditionEven,
      returnTrue,
    ],
    expectedBlockOrder: [
      'if',
      'cond_even',
      'return_true',
    ],
    maxAttempts: 3,
  );

  static final Challenge challenge2 = Challenge(
    id: 'c2',
    description: 'Return true if x is even, otherwise false.',
    type: ChallengeType.blockAssembly,
    availableBlocks: [
      ifBlock,
      conditionEven,
      returnTrue,
      returnFalse,
    ],
    expectedBlockOrder: [
      'if',
      'cond_even',
      'return_true',
      'return_false',
    ],
    maxAttempts: 3,
  );

  static final Challenge challenge3 = Challenge(
    id: 'c3',
    description: 'Complete the full conditional logic.',
    type: ChallengeType.blockAssembly,
    availableBlocks: [
      ifBlock,
      conditionEven,
      returnTrue,
      elseBlock,
      returnFalse,
    ],
    expectedBlockOrder: [
      'if',
      'cond_even',
      'return_true',
      'else',
      'return_false',
    ],
    maxAttempts: 2,
  );


    static final Room room1 = Room(
    id: 'r1',
    name: 'Basics',
    order: 0,
    isBossRoom: false,
    status: RoomStatus.unlocked,
    challenge: challenge1,
  );

  static final Room room2 = Room(
    id: 'r2',
    name: 'Condition',
    order: 1,
    isBossRoom: false,
    status: RoomStatus.locked,
    challenge: challenge2,
  );

  static final Room room3 = Room(
    id: 'r3',
    name: 'Full Logic',
    order: 2,
    isBossRoom: true,
    status: RoomStatus.locked,
    challenge: challenge3,
  );

  static final Dungeon dungeon = Dungeon(
    id: 'd1',
    name: 'Logic Dungeon',
    theme: 'Logic Basics',
    rooms: [
      room1,
      room2,
      room3,
    ],
  );
}

