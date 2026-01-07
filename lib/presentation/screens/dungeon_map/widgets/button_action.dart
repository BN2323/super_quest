import 'package:flutter/material.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';

class BottomAction extends StatelessWidget {
  final GameController controller;

  const BottomAction({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.currentRoom.isUnlocked) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          onPressed: () {
            controller.enterCurrentRoom(context);
          },
          child: Text(
            'ENTER NEXT ROOM',
            style: AppTextStyles.button,
          ),
        ),
      ),
    );
  }
}
