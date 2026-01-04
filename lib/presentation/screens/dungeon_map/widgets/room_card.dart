import 'package:flutter/material.dart';

import '../../../../domain/models/room.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';
import '../../../theme/app_spacing.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = room.status == RoomStatus.locked;

    return Opacity(
      opacity: isLocked ? 0.5 : 1,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              _getIcon(),
              color: _getColor(),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              room.name,
              style: AppTextStyles.subtitle,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (room.status) {
      case RoomStatus.completed:
        return Icons.check_circle;
      case RoomStatus.unlocked:
        return Icons.lock_open;
      case RoomStatus.locked:
        return Icons.lock;
    }
  }

  Color _getColor() {
    switch (room.status) {
      case RoomStatus.completed:
        return AppColors.success;
      case RoomStatus.unlocked:
        return AppColors.primary;
      case RoomStatus.locked:
        return AppColors.textDisabled;
    }
  }
}
