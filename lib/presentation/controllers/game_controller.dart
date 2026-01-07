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
  int _hintsUsed = 0;

  GameController({
    required this.challengeService,
    required this.gameService,
    required this.dungeon,
  }) : player = Player.initial() {
    _selectActiveRoom();
  }

  // ===== GETTERS =====

  Room get currentRoom => _selectedRoom!;
  int get hintsUsed => _hintsUsed;

  bool get canUseHint =>
      _hintsUsed < currentRoom.challenge.maxHints;

  // ===== ROOM SELECTION =====

  void selectRoom(Room room) {
    if (room.status == RoomStatus.locked) return;
    _selectedRoom = room;
    _resetChallengeState();
    notifyListeners();
  }

  void _selectActiveRoom() {
    _selectedRoom = dungeon.rooms.firstWhere(
      (r) => r.status == RoomStatus.unlocked,
      orElse: () => dungeon.rooms.first,
    );
  }

  // ===== NAVIGATION =====

  void enterCurrentRoom(BuildContext context) {
    if (currentRoom.status == RoomStatus.locked) return;

    _resetChallengeState();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoomIntroScreen(room: currentRoom),
      ),
    );
  }

  // ===== HINT SYSTEM =====

  void useHint() {
    if (!canUseHint) return;
    _hintsUsed++;
    notifyListeners();
  }

  void _resetChallengeState() {
    _hintsUsed = 0;
  }

  // ===== CHALLENGE FLOW =====

  ChallengeOutcome? submitSolution({
    required List<CodeBlock> userBlocks,
  }) {
    final bool isReplay =
        currentRoom.status == RoomStatus.completed;

    final outcome = challengeService.evaluate(
      challenge: currentRoom.challenge,
      userBlocks: userBlocks,
      hintsUsed: _hintsUsed,
    );

    if (outcome == null) return null;

    // Apply progression only if NOT replay
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

  // ===== RESET GAME =====

  void resetGame() {
    for (final room in dungeon.rooms) {
      room.reset();
    }
    dungeon.rooms.first.unlock();
    _selectActiveRoom();
    notifyListeners();
  }
}
