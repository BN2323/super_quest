import 'challenge.dart';

enum RoomStatus {
  locked,
  unlocked,
  completed,
}

class Room {
  final String id;
  final String name;
  final int order;
  final bool isBossRoom;

  RoomStatus status;
  final Challenge challenge;

  Room({
    required this.id,
    required this.name,
    required this.order,
    required this.isBossRoom,
    required this.status,
    required this.challenge,
  });

  bool get isLocked => status == RoomStatus.locked;
  bool get isUnlocked => status == RoomStatus.unlocked;
  bool get isCompleted => status == RoomStatus.completed;

  void unlock() {
    if (status == RoomStatus.locked) {
      status = RoomStatus.unlocked;
    }
  }

  void complete() {
    status = RoomStatus.completed;
  }

  void reset() {
    if (status == RoomStatus.completed) {
      status = RoomStatus.unlocked;
    }
  }
}
