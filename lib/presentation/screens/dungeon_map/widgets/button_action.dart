import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/theme/app_spacing.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';

class BottomAction extends StatelessWidget {
  final Room currentRoom;
  final Function enterCurrentRoom;
  const BottomAction({super.key, required this.currentRoom, required this.enterCurrentRoom, });

  @override
  Widget build(BuildContext context) {
    if (currentRoom.isLocked) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: PrimaryActionButton(
        label: 'ENTER ROOM',
        onPressed: () {
          enterCurrentRoom(context);
        },
      )
    );
  }
}
