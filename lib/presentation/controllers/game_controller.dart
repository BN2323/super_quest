import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/challenge_result.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/domain/services/challenge_service.dart';
import 'package:super_quest/domain/services/game_service.dart';

class GameController extends ChangeNotifier {
  final ChallengeService challengeService;
  final GameService gameService;

  Dungeon dungeon;
  late Room currentRoom;

  int attemptNumber = 1;
  ChallengeResult? lastResult;

  GameController({
    required this.challengeService,
    required this.gameService,
    required this.dungeon
  }) {
    currentRoom = gameService.getCurrentRoom(dungeon);
  }

  void submitAnswer(List<CodeBlock> userBlocks) {
    final result = challengeService.evaluate(
      challenge: currentRoom.challenge,
      userBlocks: userBlocks,
      attemptNumber: attemptNumber,
    );

    lastResult = result;

    if (result.success) {
      gameService.completeRoom(
        dungeon: dungeon, 
        room: currentRoom,
      );

      if (!gameService.isDungeonCompleted(dungeon)) {
        currentRoom = gameService.getCurrentRoom(dungeon);
        attemptNumber = 1;
      }
    } else {
      attemptNumber++;
    }

    notifyListeners();
  }

  void resetDungeon() {
    for (final room in dungeon.rooms) {
      room.status = room.order == 0 ? RoomStatus.unlocked : RoomStatus.locked;
    }

    currentRoom = gameService.getCurrentRoom(dungeon);
    attemptNumber = 1;
    lastResult = null;

    notifyListeners();
  }
}