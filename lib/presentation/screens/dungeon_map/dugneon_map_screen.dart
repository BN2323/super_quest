import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/button_action.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/dugneon_map.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/header.dart';
import '../../theme/app_colors.dart';

class DungeonMapScreen extends StatelessWidget {
  const DungeonMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // User dashboard
            Header(controller: controller),

            // Map of rooms
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DungeonMap(controller: controller),
              ),
            ),

            // Bottom call to action
            BottomAction(controller: controller),
          ],
        ),
      ),
    );
  }
}

