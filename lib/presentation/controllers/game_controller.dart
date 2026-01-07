import 'package:flutter/material.dart';
import '../../domain/models/code_block.dart';
import '../../domain/models/dungeon.dart';
import '../../domain/models/player.dart';
import '../../domain/models/room.dart';
import '../../domain/models/challenge_outcome.dart';
import '../../domain/services/challenge_service.dart';
import '../../domain/services/game_service.dart';
import '../screens/room_intro/room_intro_screen.dart';

class GameController extends ChangeNotifier {
  // ===== Services =====
  final ChallengeService challengeService;
  final GameService gameService;

  // ===== Core State =====
  final Dungeon dungeon;
  final Player player;

  Room? _selectedRoom;

  GameController({
    required this.challengeService,
    required this.gameService,
    required this.dungeon,
  }) : player = Player.initial() {
    _autoSelectActiveRoom();
  }

  // ===== GETTERS =====

  Room get currentRoom => _selectedRoom ?? _findActiveRoom();

  // ===== ROOM SELECTION =====

  void selectRoom(Room room) {
    if (room.status == RoomStatus.locked) return;
    _selectedRoom = room;
    notifyListeners();
  }

  void _autoSelectActiveRoom() {
    _selectedRoom = _findActiveRoom();
  }

  Room _findActiveRoom() {
    return dungeon.rooms.firstWhere(
      (r) => r.status == RoomStatus.unlocked,
      orElse: () => dungeon.rooms.last,
    );
  }

  // ===== NAVIGATION =====

  void enterCurrentRoom(BuildContext context) {
    if (currentRoom.status == RoomStatus.locked) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoomIntroScreen(room: currentRoom),
      ),
    );
  }

  // ===== CHALLENGE FLOW =====

  ChallengeOutcome? submitSolution({
    required List<CodeBlock> userBlocks,
  }) {
    final isReplay = currentRoom.status == RoomStatus.completed;

    final outcome = challengeService.evaluateSolution(
      challenge: currentRoom.challenge,
      userBlocks: userBlocks,
    );

    if (outcome == null) return null;

    // Apply game changes only if NOT replay
    if (!isReplay) {
      gameService.applyOutcome(
        outcome: outcome,
        player: player,
        currentRoom: currentRoom,
        dungeon: dungeon,
      );
    }

    notifyListeners();
    return outcome;
  }

  // ===== RESET =====

  void resetGame() {
    for (final room in dungeon.rooms) {
      room.reset();
    }
    dungeon.rooms.first.unlock();
    _autoSelectActiveRoom();
    notifyListeners();
  }
}
