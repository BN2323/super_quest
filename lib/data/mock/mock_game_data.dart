import 'package:super_quest/domain/models/challenge.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';

class MockGameData {
  // ===== CODE BLOCKS =====

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

  static final CodeBlock conditionEven = CodeBlock(
    id: 'cond_even',
    type: CodeBlockType.condition,
    label: 'x % 2 == 0',
    value: 'x % 2 == 0',
  );

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

  // ===== CHALLENGES =====

  /// Room 1 – Simple if condition
  static final Challenge challengeBasics = Challenge(
    id: 'c1',
    type: ChallengeType.blockAssembly,
    description: 'Return true if x is even.',
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
    maxHints: 2,
  );

  /// Room 2 – If with fallback
  static final Challenge challengeCondition = Challenge(
    id: 'c2',
    type: ChallengeType.blockAssembly,
    description: 'Return true if x is even, otherwise return false.',
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
    maxHints: 2,
  );

  /// Room 3 – Full if / else logic (Boss)
  static final Challenge challengeFullLogic = Challenge(
    id: 'c3',
    type: ChallengeType.blockAssembly,
    description: 'Complete the full conditional logic using if and else.',
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
    maxHints: 1, // Boss room → stricter
  );

  // ===== ROOMS =====

  static final Room room1 = Room(
    id: 'r1',
    name: 'Basics',
    order: 0,
    isBossRoom: false,
    status: RoomStatus.unlocked,
    challenge: challengeBasics,
  );

  static final Room room2 = Room(
    id: 'r2',
    name: 'Conditions',
    order: 1,
    isBossRoom: false,
    status: RoomStatus.locked,
    challenge: challengeCondition,
  );

  static final Room room3 = Room(
    id: 'r3',
    name: 'Full Logic',
    order: 2,
    isBossRoom: true,
    status: RoomStatus.locked,
    challenge: challengeFullLogic,
  );

  static final Room room4 = Room(
    id: 'r4',
    name: 'Advanced Logic',
    order: 3,
    isBossRoom: false,
    status: RoomStatus.locked,
    challenge: challengeFullLogic,
  );

  static final Room room5 = Room(
    id: 'r5',
    name: 'Logic Mastery',
    order: 4,
    isBossRoom: true,
    status: RoomStatus.locked,
    challenge: challengeFullLogic,
  );

  // ===== DUNGEON =====

  static final Dungeon dungeon = Dungeon(
    id: 'd1',
    name: 'Logic Dungeon',
    theme: 'Conditional Thinking',
    rooms: [
      room1,
      room2,
      room3,
      room4,
      room5,
    ],
  );
}
