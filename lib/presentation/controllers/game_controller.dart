import 'package:flutter/material.dart';
import '../../domain/models/code_block.dart';
import '../../domain/models/challenge_outcome.dart';
import '../../domain/models/dungeon.dart';
import '../../domain/models/player.dart';
import '../../domain/models/room.dart';
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

  Room _currentRoom;
  int _hintsUsed = 0;

  // ===== Constructor =====
  GameController({
    required this.challengeService,
    required this.gameService,
    required this.dungeon,
  })  : player = Player.initial(),
        _currentRoom = _initialActiveRoom(dungeon);

  // ===== GETTERS =====

  Room get currentRoom => _currentRoom;
  int get hintsUsed => _hintsUsed;

  bool get canUseHint =>
      !_currentRoom.isLocked &&
      _hintsUsed < _currentRoom.challenge.maxHints;

  // ===== ROOM SELECTION =====
  // (manual selection still allowed, but not required)

  void selectRoom(Room room) {
    if (room.isLocked) return;
    _setCurrentRoom(room);
  }

  // ===== NAVIGATION =====

  void enterCurrentRoom(BuildContext context) {
    if (_currentRoom.isLocked) return;

    _resetAttemptState();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoomIntroScreen(room: _currentRoom),
      ),
    );
  }

  // ===== HINT SYSTEM =====

  void useHint() {
    if (!canUseHint) return;
    _hintsUsed++;
    notifyListeners();
  }

  // ===== CHALLENGE FLOW =====

  ChallengeOutcome? submitSolution({
    required List<CodeBlock> userBlocks,
  }) {
    final bool isReplay = _currentRoom.isCompleted;

    final outcome = challengeService.evaluate(
      challenge: _currentRoom.challenge,
      userBlocks: userBlocks,
      hintsUsed: _hintsUsed,
    );

    if (outcome == null) return null;

    if (!isReplay) {
      gameService.applyOutcome(
        outcome: outcome,
        player: player,
        currentRoom: _currentRoom,
        dungeon: dungeon,
      );

      // ✅ Automatically move to next active room
      _selectNextActiveRoom();
    }

    notifyListeners();
    return outcome;
  }

  // ===== GAME RESET =====

  void resetGame() {
    for (final room in dungeon.rooms) {
      room.reset();
    }
    dungeon.rooms.first.unlock();
    _currentRoom = dungeon.rooms.first;
    notifyListeners();
  }

  // ===== INTERNAL HELPERS =====

  void _setCurrentRoom(Room room) {
    _currentRoom = room;
    _resetAttemptState();
    notifyListeners();
  }

  void _resetAttemptState() {
    _hintsUsed = 0;
  }

  void _selectNextActiveRoom() {
    final unlocked = dungeon.rooms
        .where((r) => r.status == RoomStatus.unlocked)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    if (unlocked.isNotEmpty) {
      _currentRoom = unlocked.first;
    }
  }

  static Room _initialActiveRoom(Dungeon dungeon) {
    return dungeon.rooms.firstWhere(
      (r) => r.status == RoomStatus.unlocked,
      orElse: () => dungeon.rooms.first,
    );
  }
}
