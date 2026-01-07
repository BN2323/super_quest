import 'package:super_quest/data/models/room_progress.dart';
import 'package:super_quest/domain/models/dungeon.dart';

class DungeonProgress {
  final String dungeonId;
  final DungeonStatus status;
  final List<RoomProgress> rooms;

  DungeonProgress({
    required this.dungeonId,
    required this.status,
    required this.rooms,
  });

  Map<String, dynamic> toJson() => {
    'dungeonId': dungeonId,
    'status': status.name,
    'rooms': rooms.map((r) => r.toJson()).toList(),
  };

  factory DungeonProgress.fromJson(Map<String, dynamic> json) {
    return DungeonProgress(
      dungeonId: json['dungeonId'],
      status: DungeonStatus.values
          .firstWhere((e) => e.name == json['status']),
      rooms: (json['rooms'] as List)
          .map((r) => RoomProgress.fromJson(r))
          .toList(),
    );
  }
}
