import 'package:super_quest/domain/models/challenge.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/game_world.dart';
import 'package:super_quest/domain/models/room.dart';

class MockGameData {
  // ======================
  // SHARED CODE BLOCKS
  // ======================

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

  static final CodeBlock forBlock = CodeBlock(
    id: 'for',
    type: CodeBlockType.keyword,
    label: 'for',
    value: 'for',
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

  // ======================
  // LOGIC DUNGEON
  // ======================

  static final Dungeon logicDungeon = Dungeon(
    id: 'd_logic',
    name: 'Logic Dungeon',
    theme: 'Conditional Thinking',
    status: DungeonStatus.unlocked,
    rooms: [
      // ---- Room 1 ----
      Room(
        id: 'r_logic_1',
        name: 'Basics',
        order: 0,
        isBossRoom: false,
        status: RoomStatus.unlocked,
        challenges: [
          Challenge(
            id: 'c_logic_1',
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
          ),
        ],
      ),

      // ---- Room 2 ----
      Room(
        id: 'r_logic_2',
        name: 'Conditions',
        order: 1,
        isBossRoom: false,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_logic_2',
            type: ChallengeType.blockAssembly,
            description: 'Return true if x is even, otherwise false.',
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
          ),
        ],
      ),

      // ---- Boss Room (3 Challenges) ----
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
            description: 'Check if x is even.',
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
          ),
          Challenge(
            id: 'c_logic_boss_2',
            type: ChallengeType.blockAssembly,
            description: 'Handle both true and false cases.',
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
          ),
          Challenge(
            id: 'c_logic_boss_3',
            type: ChallengeType.blockAssembly,
            description: 'Master full if / else logic.',
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
            maxHints: 1,
          ),
        ],
      ),
    ],
  );

  // ======================
  // LOOP DUNGEON
  // ======================

  static final Dungeon loopDungeon = Dungeon(
    id: 'd_loop',
    name: 'Loop Dungeon',
    theme: 'Iteration & Control',
    status: DungeonStatus.locked,
    rooms: [
      // ---- Room 1 ----
      Room(
        id: 'r_loop_1',
        name: 'Simple Loop',
        order: 0,
        isBossRoom: false,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_loop_1',
            type: ChallengeType.blockAssembly,
            description: 'Repeat an action using a loop.',
            availableBlocks: [
              forBlock,
            ],
            expectedBlockOrder: [
              'for',
            ],
            maxHints: 2,
          ),
        ],
      ),

      // ---- Boss Room (3 Challenges) ----
      Room(
        id: 'r_loop_boss',
        name: 'Loop Boss',
        order: 1,
        isBossRoom: true,
        status: RoomStatus.locked,
        challenges: [
          Challenge(
            id: 'c_loop_boss_1',
            type: ChallengeType.blockAssembly,
            description: 'Use a loop.',
            availableBlocks: [
              forBlock,
            ],
            expectedBlockOrder: [
              'for',
            ],
            maxHints: 2,
          ),
          Challenge(
            id: 'c_loop_boss_2',
            type: ChallengeType.blockAssembly,
            description: 'Combine loop with condition.',
            availableBlocks: [
              forBlock,
              ifBlock,
              conditionEven,
            ],
            expectedBlockOrder: [
              'for',
              'if',
              'cond_even',
            ],
            maxHints: 1,
          ),
          Challenge(
            id: 'c_loop_boss_3',
            type: ChallengeType.blockAssembly,
            description: 'Reorder loop and condition logic.',
            availableBlocks: [
              forBlock,
              ifBlock,
              conditionEven,
            ],
            expectedBlockOrder: [
              'if',
              'for',
              'cond_even',
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
      // add more later (functions, arrays, final boss, etc.)
    ],
  );
}
