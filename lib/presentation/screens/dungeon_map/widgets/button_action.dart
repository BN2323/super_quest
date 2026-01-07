import 'package:flutter/material.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';

class BottomAction extends StatelessWidget {
  final GameController controller;

  const BottomAction({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.currentRoom.isLocked) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: PrimaryActionButton(
        label: 'ENTER ROOM',
        onPressed: () {
          controller.enterCurrentRoom(context);
        },
      )
    );
  }
}
