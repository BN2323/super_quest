import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_quest/presentation/controllers/game_controller.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/button_action.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/dugneon_map.dart';
import 'package:super_quest/presentation/screens/dungeon_map/widgets/header.dart';
import 'package:super_quest/presentation/theme/app_text_styles.dart';
import '../../theme/app_colors.dart';

class DungeonMapScreen extends StatelessWidget {
  const DungeonMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          controller.currentDungeon.name,
          style: AppTextStyles.title,
        ),
        centerTitle: true,
      ),
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

