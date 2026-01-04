import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';

class GameService {
  Room getCurrentRoom(Dungeon dungeon) {
    return dungeon.rooms.firstWhere(
      (room) => room.status == RoomStatus.unlocked,
    );

  }

  void completeRoom({
    required Dungeon dungeon,
    required Room room,
  }) {
    room.status = RoomStatus.completed;

    final currentIndex = dungeon.rooms.indexOf(room);
    final nextIndex = currentIndex + 1;

    if (nextIndex < dungeon.rooms.length) {
      final nextRoom = dungeon.rooms[nextIndex];

      if (nextRoom.status == RoomStatus.locked) {
        nextRoom.status = RoomStatus.unlocked;
      }
    }
  }

  bool isDungeonCompleted(Dungeon dungeon) {
    return dungeon.rooms.every(
      (room) => room.status == RoomStatus.completed,
    );
  }
}