import 'package:flutter/material.dart';

import '../../domain/models/challenge_result.dart';
import '../../domain/models/dungeon.dart';
import '../../domain/models/player.dart';
import '../../domain/models/room.dart';
import '../../domain/models/code_block.dart';
import '../../domain/services/challenge_service.dart';
import '../../domain/services/game_service.dart';

class GameController extends ChangeNotifier {
  // ===== Services =====
  final ChallengeService challengeService;
  final GameService gameService;

  // ===== Core State =====
  final Dungeon dungeon;
  final Player player;

  int _currentRoomIndex = 0;
  int _attemptsUsed = 0;

  GameController({
    required this.challengeService,
    required this.gameService,
    required this.dungeon,
  }) : player = Player.initial();

  // ===== GETTERS =====
  int get currentRoomIndex => _currentRoomIndex;
  Room get currentRoom => dungeon.rooms[_currentRoomIndex];
  int get attemptsUsed => _attemptsUsed;

  // ===== GAME FLOW =====

  void enterRoom(Room room) {
    _currentRoomIndex = dungeon.rooms.indexOf(room);
    _attemptsUsed = 0;
    notifyListeners();
  }

  ChallengeResult submitChallenge({
    required List<CodeBlock> userBlocks,
  }) {
    _attemptsUsed++;

    // 1️⃣ Validate challenge
    final result = challengeService.submitAttempt(
      challenge: currentRoom.challenge,
      userBlocks: userBlocks,
      attemptNumber: _attemptsUsed,
    );

    // 2️⃣ Apply result to game world
    gameService.applyChallengeResult(
      result: result,
      player: player,
      currentRoom: currentRoom,
      dungeon: dungeon,
    );

    notifyListeners();
    return result;
  }

  void resetDungeon() {
    _currentRoomIndex = 0;
    _attemptsUsed = 0;

    for (final room in dungeon.rooms) {
      room.status = RoomStatus.locked;
    }

    dungeon.rooms.first.unlock();
    notifyListeners();
  }
}
