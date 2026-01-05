import 'package:flutter/material.dart';
import '../../../../domain/models/room.dart';
import '../../../theme/app_colors.dart';

class RoomNode extends StatelessWidget {
  final Room room;
  final VoidCallback? onTap;

  const RoomNode({
    super.key,
    required this.room,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _colorForState(room.status);

    return GestureDetector(
      onTap: room.status == RoomStatus.unlocked ? onTap : null,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: room.status == RoomStatus.unlocked ? 1 : 0.95,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: _icon(),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    switch (room.status) {
      case RoomStatus.completed:
        return const Icon(Icons.check, color: Colors.white);
      case RoomStatus.unlocked:
        return const Icon(Icons.play_arrow, color: Colors.white);
      case RoomStatus.locked:
        return const Icon(Icons.lock, color: Colors.white70);
    }
  }

  Color _colorForState(RoomStatus status) {
    switch (status) {
      case RoomStatus.completed:
        return AppColors.success;
      case RoomStatus.unlocked:
        return AppColors.primary;
      case RoomStatus.locked:
        return AppColors.roomLocked;
    }
  }
}
