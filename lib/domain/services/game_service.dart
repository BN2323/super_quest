import '../models/challenge_outcome.dart';
import '../models/dungeon.dart';
import '../models/player.dart';
import '../models/room.dart';

class GameService {
  /// Applies the result of a successfully completed challenge.
  /// - Marks the room as completed
  /// - Grants XP to the player
  /// - Unlocks the next room (if any)
  void applyOutcome({
    required ChallengeOutcome outcome,
    required Player player,
    required Room currentRoom,
    required Dungeon dungeon,
  }) {
    _completeRoom(currentRoom);
    _grantXp(player, outcome.xpGained);
    _unlockNextRoom(dungeon, currentRoom);
  }

  // ===== INTERNAL RULES =====

  void _completeRoom(Room room) {
    if (!room.isCompleted) {
      room.complete();
    }
  }

  void _grantXp(Player player, int xp) {
    if (xp > 0) {
      player.addXp(xp);
    }
  }

  void _unlockNextRoom(Dungeon dungeon, Room currentRoom) {
    final nextRoom = _findNextRoom(dungeon, currentRoom);

    if (nextRoom != null && nextRoom.isLocked) {
      nextRoom.unlock();
    }
  }

  Room? _findNextRoom(Dungeon dungeon, Room currentRoom) {
    final rooms = dungeon.rooms
      ..sort((a, b) => a.order.compareTo(b.order));

    final index = rooms.indexWhere(
      (room) => room.id == currentRoom.id,
    );

    if (index == -1) return null;
    if (index >= rooms.length - 1) return null;

    return rooms[index + 1];
  }
}