import '../models/challenge_result.dart';
import '../models/dungeon.dart';
import '../models/player.dart';
import '../models/room.dart';

class GameService {
  void applyChallengeResult({
    required ChallengeResult result,
    required Player player,
    required Room currentRoom,
    required Dungeon dungeon,
  }) {
    if (!result.success) return;

    currentRoom.complete();

    player.addXp(50);

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
    final currentIndex =
        dungeon.rooms.indexWhere((r) => r.id == currentRoom.id);

    if (currentIndex == -1) return null;
    if (currentIndex >= dungeon.rooms.length - 1) return null;

    return dungeon.rooms[currentIndex + 1];
  }
}
