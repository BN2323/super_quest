import 'package:super_quest/domain/models/challenge.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/game_world.dart';
import 'package:super_quest/domain/models/room.dart';

class GameData {
  // ======================
  // SHARED CODE BLOCKS
  // ======================

  static final ifBlock = CodeBlock(
    id: 'if',
    type: CodeBlockType.keyword,
    label: 'if',
    value: 'if',
  );

  static final elseBlock = CodeBlock(
    id: 'else',
    type: CodeBlockType.keyword,
    label: 'else',
    value: 'else',
  );

  static final forBlock = CodeBlock(
    id: 'for',
    type: CodeBlockType.keyword,
    label: 'for',
    value: 'for',
  );

  static final whileBlock = CodeBlock(
    id: 'while',
    type: CodeBlockType.keyword,
    label: 'while',
    value: 'while',
  );

  static final condEven = CodeBlock(
    id: 'cond_even',
    type: CodeBlockType.condition,
    label: 'x % 2 == 0',
    value: 'x % 2 == 0',
  );

  static final condPositive = CodeBlock(
    id: 'cond_positive',
    type: CodeBlockType.condition,
    label: 'x > 0',
    value: 'x > 0',
  );

  static final returnTrue = CodeBlock(
    id: 'return_true',
    type: CodeBlockType.action,
    label: 'return true',
    value: 'true',
  );

  static final returnFalse = CodeBlock(
    id: 'return_false',
    type: CodeBlockType.action,
    label: 'return false',
    value: 'false',
  );

  // ======================
  // DUNGEON 1 — LOGIC
  // ======================

  static final Dungeon logicDungeon = Dungeon(
    id: 'd_logic',
    name: 'Logic Dungeon',
    theme: 'Conditions & Decisions',
    status: DungeonStatus.unlocked,
    rooms: [
      Room(
        id: 'r_logic_1',
        name: 'If Basics',
        order: 0,
        isBossRoom: false,
        status: RoomStatus.unlocked,
        challenges: [
          Challenge(
            id: 'c_logic_1',
            type: ChallengeType.blockAssembly,
            description: 'Return true if x is even.',
            availableBlocks: [ifBlock, condEven, returnTrue],
            expectedBlockOrder: ['if', 'cond_even', 'return_true'],
            maxHints: 2,
          ),
        ],
      ),

      Room(
        id: 'r_logic_2',
        name: 'If Else',
        order: 1,
        isBossRoom: false,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_logic_2',
            type: ChallengeType.blockAssembly,
            description: 'Return true if x is even, otherwise false.',
            availableBlocks: [ifBlock, condEven, returnTrue, returnFalse],
            expectedBlockOrder: [
              'if',
              'cond_even',
              'return_true',
              'return_false'
            ],
            maxHints: 2,
          ),
        ],
      ),

      Room(
        id: 'r_logic_boss',
        name: 'Logic Boss',
        order: 2,
        isBossRoom: true,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_logic_boss_1',
            type: ChallengeType.blockAssembly,
            description: 'Check if x is positive.',
            availableBlocks: [ifBlock, condPositive, returnTrue],
            expectedBlockOrder: ['if', 'cond_positive', 'return_true'],
            maxHints: 2,
          ),
          Challenge(
            id: 'c_logic_boss_2',
            type: ChallengeType.blockAssembly,
            description: 'Handle both positive and negative.',
            availableBlocks: [
              ifBlock,
              condPositive,
              returnTrue,
              elseBlock,
              returnFalse
            ],
            expectedBlockOrder: [
              'if',
              'cond_positive',
              'return_true',
              'else',
              'return_false'
            ],
            maxHints: 1,
          ),
        ],
      ),
    ],
  );

  // ======================
  // DUNGEON 2 — LOOPS
  // ======================

  static final Dungeon loopDungeon = Dungeon(
    id: 'd_loop',
    name: 'Loop Dungeon',
    theme: 'Iteration',
    status: DungeonStatus.locked,
    rooms: [
      Room(
        id: 'r_loop_1',
        name: 'For Loop',
        order: 0,
        isBossRoom: false,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_loop_1',
            type: ChallengeType.blockAssembly,
            description: 'Repeat using a for loop.',
            availableBlocks: [forBlock],
            expectedBlockOrder: ['for'],
            maxHints: 2,
          ),
        ],
      ),

      Room(
        id: 'r_loop_2',
        name: 'While Loop',
        order: 1,
        isBossRoom: false,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_loop_2',
            type: ChallengeType.blockAssembly,
            description: 'Repeat while x is positive.',
            availableBlocks: [whileBlock, condPositive],
            expectedBlockOrder: ['while', 'cond_positive'],
            maxHints: 2,
          ),
        ],
      ),

      Room(
        id: 'r_loop_boss',
        name: 'Loop Boss',
        order: 2,
        isBossRoom: true,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_loop_boss_1',
            type: ChallengeType.blockAssembly,
            description: 'Loop with condition.',
            availableBlocks: [forBlock, ifBlock, condEven],
            expectedBlockOrder: ['for', 'if', 'cond_even'],
            maxHints: 1,
          ),
          Challenge(
            id: 'c_loop_boss_2',
            type: ChallengeType.blockAssembly,
            description: 'Nested logic inside loop.',
            availableBlocks: [
              forBlock,
              ifBlock,
              condEven,
              returnTrue
            ],
            expectedBlockOrder: [
              'for',
              'if',
              'cond_even',
              'return_true'
            ],
            maxHints: 1,
          ),
        ],
      ),
    ],
  );

  // ======================
  // DUNGEON 3 — MIXED LOGIC
  // ======================

  static final Dungeon controlDungeon = Dungeon(
    id: 'd_control',
    name: 'Control Dungeon',
    theme: 'Flow Control',
    status: DungeonStatus.locked,
    rooms: [
      Room(
        id: 'r_control_1',
        name: 'Conditions + Loop',
        order: 0,
        isBossRoom: false,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_control_1',
            type: ChallengeType.blockAssembly,
            description: 'Loop and check even numbers.',
            availableBlocks: [forBlock, ifBlock, condEven],
            expectedBlockOrder: ['for', 'if', 'cond_even'],
            maxHints: 2,
          ),
        ],
      ),

      Room(
        id: 'r_control_boss',
        name: 'Control Boss',
        order: 1,
        isBossRoom: true,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_control_boss_1',
            type: ChallengeType.blockAssembly,
            description: 'Full control flow.',
            availableBlocks: [
              forBlock,
              ifBlock,
              condEven,
              elseBlock,
              returnFalse
            ],
            expectedBlockOrder: [
              'for',
              'if',
              'cond_even',
              'else',
              'return_false'
            ],
            maxHints: 1,
          ),
        ],
      ),
    ],
  );

  // ======================
  // GAME WORLD
  // ======================

  static final GameWorld world = GameWorld(
    dungeons: [
      logicDungeon,
      loopDungeon,
      controlDungeon,
    ],
  );
}
