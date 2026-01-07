import 'package:super_quest/domain/models/room.dart';

enum DungeonStatus {
  locked,
  unlocked,
  completed,
}

class Dungeon {
  final String id;
  final String name;
  final String theme;
  final List<Room> rooms;

  DungeonStatus status;

  Dungeon({
    required this.id,
    required this.name,
    required this.theme,
    required this.rooms,
    this.status = DungeonStatus.locked,
  });

  bool get isLocked => status == DungeonStatus.locked;
  bool get isUnlocked => status == DungeonStatus.unlocked;
  bool get isCompleted => status == DungeonStatus.completed;

  bool get isFullyCompleted =>
      rooms.every((room) => room.isCompleted);

  void unlock() {
    if (status == DungeonStatus.locked) {
      status = DungeonStatus.unlocked;
    }
  }

  void complete() {
    status = DungeonStatus.completed;
  }

}
