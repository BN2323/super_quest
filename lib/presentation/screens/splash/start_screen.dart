import 'package:flutter/material.dart';
import 'package:super_quest/presentation/screens/dungeon_map/dugneon_map_screen.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SuperQuest',
                  style: AppTextStyles.titleLarge,
                ),

                const SizedBox(height: AppSpacing.sm),

                Text(
                  'Conquer logic dungeons\none room at a time',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: AppSpacing.xl),

                PrimaryActionButton(
                  label: 'START ADVENTURE',
                  onPressed: () { 
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DungeonMapScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
