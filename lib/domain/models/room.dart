import 'package:super_quest/domain/models/challenge.dart';

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
}
