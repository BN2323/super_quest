import 'package:flutter/material.dart';
import 'package:super_quest/data/models/dungeon_progress.dart';
import 'package:super_quest/data/models/game_save.dart';
import 'package:super_quest/data/models/room_progress.dart';
import 'package:super_quest/data/repositories/game_save_repository.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/game_world.dart';
import 'package:super_quest/domain/models/player.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/domain/models/submit_result.dart';
import 'package:super_quest/domain/services/challenge_service.dart';
import 'package:super_quest/domain/services/game_service.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/button_action.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/dugneon_map.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/header.dart';
import 'package:super_quest/presentation/screens/room_intro/room_intro_screen.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';
import '../../theme/app_colors.dart';

class DungeonMapScreen extends StatefulWidget {
  final GameSaveRepository saveRepository;
  final GameWorld world;
  final Player player;
  final Dungeon selectedDungeon;

  const DungeonMapScreen({super.key, required this.saveRepository, required this.world, required this.player, required this.selectedDungeon});

  @override
  State<DungeonMapScreen> createState() => _DungeonMapScreenState();
}

class _DungeonMapScreenState extends State<DungeonMapScreen> {
  late Dungeon currentDungeon;
  late Room currentRoom;

  final gameService = GameService();
  final challengeService = ChallengeService();

   @override
  void initState() {
    super.initState();
    currentDungeon = widget.selectedDungeon;
    currentRoom = _findInitialRoom(currentDungeon);
  }

  Room _findInitialRoom(Dungeon dungeon) {
    return dungeon.rooms.firstWhere(
      (r) => r.isUnlocked && !r.isCompleted,
      orElse: () => dungeon.rooms.first,
    );
  }

  void _selectRoom(Room room) {
    if (room.isLocked) return;

    setState(() {
      currentRoom = room;
    });
  }

  void _enterCurrentRoom(BuildContext context) {
    if (currentRoom.isLocked) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoomIntroScreen(currentDungeon: currentDungeon, currentRoom: currentRoom, onSubmit: _submitChallenge,),
      ),
    );
  }

  SubmitResult _submitChallenge({
    required Room currentRoom,
    required Dungeon currentDungeon,
    required List<CodeBlock> userBlocks,
    required int hintsUsed,
  }) {
    final challenge = currentRoom.currentChallenge;

    final outcome = challengeService.evaluate(
      challenge: challenge,
      userBlocks: userBlocks,
      hintsUsed: hintsUsed,
    );

    if (outcome == null) {
      throw Exception('Invalid solution');
    }

    final result = gameService.submitChallenge(
      dungeon: currentDungeon,
      room: currentRoom,
      outcome: outcome,
      player: widget.player,
    );

    if (result.dungeonCompleted) {
      gameService.unlockNextDungeon(widget.world, currentDungeon);
    }

    setState(() {
      if (result.roomCompleted) {
        currentRoom = _findInitialRoom(currentDungeon);
      }
    });

    saveGame();
    return result;
  }



  Future<void> saveGame() async {
    final save = GameSave(
      level: widget.player.level,
      xp: widget.player.xp,
      dungeons: widget.world.dungeons.map((dungeon) {
        return DungeonProgress(
          dungeonId: dungeon.id,
          status: dungeon.status,
          rooms: dungeon.rooms.map((room) {
            return RoomProgress(
              roomId: room.id,
              status: room.status,
              challengeIndex: room.currentChallengeIndex,
            );
          }).toList(),
        );
      }).toList(),
    );

    await widget.saveRepository.save(save);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          currentDungeon.name,
          style: AppTextStyles.title,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // User dashboard
            Header(player: widget.player, dungeon: currentDungeon,),

            // Map of rooms
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DungeonMap(currentDungeon: currentDungeon, currentRoom: currentRoom, selectRoom: _selectRoom,),
              ),
            ),

            // Bottom call to action
            BottomAction(currentRoom: currentRoom, enterCurrentRoom: _enterCurrentRoom,),
          ],
        ),
      ),
    );
  }
}

