import '../models/challenge_outcome.dart';
import '../models/dungeon.dart';
import '../models/player.dart';
import '../models/room.dart';

class GameService {
  void applyOutcome({
    required ChallengeOutcome outcome,
    required Player player,
    required Room currentRoom,
    required Dungeon dungeon,
  }) {
    currentRoom.complete();

    player.addXp(outcome.xpGained);

    final nextRoom = _getNextRoom(
      dungeon: dungeon,
      currentRoom: currentRoom,
    );

    nextRoom?.unlock();
  }

  Room? _getNextRoom({
    required Dungeon dungeon,
    required Room currentRoom,
  }) {
    final index = dungeon.rooms.indexWhere(
      (r) => r.id == currentRoom.id,
    );

    if (index == -1) return null;
    if (index >= dungeon.rooms.length - 1) return null;

    return dungeon.rooms[index + 1];
  }
}
