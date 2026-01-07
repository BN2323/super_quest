import 'package:flutter/material.dart';
import '../../domain/models/code_block.dart';
import '../../domain/models/challenge_outcome.dart';
import '../../domain/models/dungeon.dart';
import '../../domain/models/game_world.dart';
import '../../domain/models/player.dart';
import '../../domain/models/room.dart';
import '../../domain/services/challenge_service.dart';
import '../../domain/services/game_service.dart';
import '../screens/room_intro/room_intro_screen.dart';

class GameController extends ChangeNotifier {
  // ===== SERVICES =====
  final ChallengeService challengeService;
  final GameService gameService;

  // ===== GAME STATE =====
  final GameWorld world;
  final Player player;

  late Dungeon _currentDungeon;
  late Room _currentRoom;

  int _hintsUsed = 0;

  // ===== CONSTRUCTOR =====
  GameController({
    required this.challengeService,
    required this.gameService,
    required this.world,
  }) : player = Player.initial() {
    _currentDungeon = world.firstDungeon;
    _currentRoom = _findInitialRoom(_currentDungeon);
  }

  // ===== GETTERS =====

  Dungeon get currentDungeon => _currentDungeon;
  Room get currentRoom => _currentRoom;

  int get hintsUsed => _hintsUsed;

  bool get canUseHint =>
      _hintsUsed < _currentRoom.currentChallenge.maxHints;

  // ===== INITIALIZATION HELPERS =====

  Room _findInitialRoom(Dungeon dungeon) {
    return dungeon.rooms.firstWhere(
      (r) => r.isUnlocked && !r.isCompleted,
      orElse: () => dungeon.rooms.first,
    );
  }

  // ===== DUNGEON SELECTION =====

  /// Allows selecting unlocked OR completed dungeons
  void selectDungeon(Dungeon dungeon) {
    _currentDungeon = dungeon;
    _currentRoom = _findInitialRoom(dungeon);
    _resetAttemptState();
    notifyListeners();
  }

  // ===== ROOM SELECTION =====

  /// Allows entering unlocked OR completed rooms
  void selectRoom(Room room) {
    if (room.isLocked) return;

    _currentRoom = room;
    _resetAttemptState();
    notifyListeners();
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

  void _resetAttemptState() {
    _hintsUsed = 0;
  }

  // ===== CHALLENGE FLOW =====

  ChallengeOutcome? submitSolution({
    required List<CodeBlock> userBlocks,
  }) {
    final room = _currentRoom;
    final challenge = room.currentChallenge;

    final bool isReplay = room.isCompleted;

    final outcome = challengeService.evaluate(
      challenge: challenge,
      userBlocks: userBlocks,
      hintsUsed: _hintsUsed,
    );

    if (outcome == null) return null;

    // Replay → no progression
    if (isReplay) {
      _resetAttemptState();
      notifyListeners();
      return outcome;
    }

    // Progress inside room
    if (!room.isLastChallenge) {
      room.advanceChallenge();
    } else {
      // Complete room
      room.complete();

      gameService.applyOutcome(
        outcome: outcome,
        player: player,
        currentRoom: room,
        dungeon: _currentDungeon,
      );

      if (isCurrentDungeonCompleted) {
        completeCurrentDungeon();
      } else {
        _currentRoom = _findInitialRoom(_currentDungeon);
      }
    }

    _resetAttemptState();
    notifyListeners();
    return outcome;
  }

  // ===== READ-ONLY HELPERS =====

  /// Next room in current dungeon (if unlocked)
  Room? get nextUnlockedRoom {
    final rooms = [..._currentDungeon.rooms]
      ..sort((a, b) => a.order.compareTo(b.order));

    final index = rooms.indexWhere((r) => r.id == _currentRoom.id);
    if (index == -1 || index + 1 >= rooms.length) return null;

    final next = rooms[index + 1];
    return next.isUnlocked || next.isCompleted ? next : null;
  }

  /// Dungeon completion check
  bool get isCurrentDungeonCompleted {
    return _currentDungeon.rooms.every((r) => r.isCompleted);
  }

  void completeCurrentDungeon() {
    if(_currentDungeon.isCompleted) return;

    final dungeon = _currentDungeon;

    // Mark dungeon completed
    dungeon.complete();

    // Unlock next dungeon
    final index = world.dungeons.indexOf(dungeon);

    if (index != -1 && index + 1 < world.dungeons.length) {
      final nextDungeon = world.dungeons[index + 1];
      nextDungeon.unlock();
      
      if (nextDungeon.rooms.isNotEmpty) {
        nextDungeon.rooms.first.unlock();
      }
    }


    notifyListeners();
  }

  // ===== RESET GAME =====

  void resetGame() {
    for (final dungeon in world.dungeons) {
      for (final room in dungeon.rooms) {
        room.reset();
      }
      dungeon.rooms.first.unlock();
    }

    _currentDungeon = world.firstDungeon;
    _currentRoom = _findInitialRoom(_currentDungeon);
    notifyListeners();
  }
}
