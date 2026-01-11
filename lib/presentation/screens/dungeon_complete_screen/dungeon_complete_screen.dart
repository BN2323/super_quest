import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_text_styles.dart';
import '../../widgets/buttons/primary_action_button.dart';

class DungeonCompleteScreen extends StatelessWidget {
  final Dungeon dungeon;

  const DungeonCompleteScreen({
    super.key,
    required this.dungeon,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ===== TITLE =====
                Text(
                  'Dungeon Complete!',
                  style: AppTextStyles.titleLarge.copyWith(
                    color: AppColors.accent,
                  ),
                ),
            
                const SizedBox(height: AppSpacing.md),
            
                Text(
                  dungeon.name,
                  style: AppTextStyles.title,
                ),
            
                const SizedBox(height: AppSpacing.lg),
            
                // ===== ACTIONS =====
                PrimaryActionButton(
                  label: 'BACK TO DUNGEON SELECT',
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);

                  },
                ),
            
                const SizedBox(height: AppSpacing.md),
            
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'REPLAY THIS DUNGEON',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
