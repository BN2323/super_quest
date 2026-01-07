import 'package:super_quest/domain/models/room.dart';

class RoomProgress {
  final String roomId;
  final RoomStatus status;
  final int challengeIndex;

  RoomProgress({
    required this.roomId,
    required this.status,
    required this.challengeIndex,
  });

  Map<String, dynamic> toJson() => {
    'roomId': roomId,
    'status': status.name,
    'challengeIndex': challengeIndex,
  };

  factory RoomProgress.fromJson(Map<String, dynamic> json) {
    return RoomProgress(
      roomId: json['roomId'],
      status: RoomStatus.values
          .firstWhere((e) => e.name == json['status']),
      challengeIndex: json['challengeIndex'],
    );
  }
}
