import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/code_block.dart';
import 'package:super_quest/domain/models/dungeon.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/domain/models/submit_result.dart';
import 'package:super_quest/presentation/screens/challenge/challenge_screen.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';
import 'package:super_quest/presentation/widgets/cards/info_card.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

class RoomIntroScreen extends StatelessWidget {
  final Dungeon currentDungeon;
  final Room currentRoom;

  final SubmitResult? Function({
    required Room currentRoom,
    required Dungeon currentDungeon,
    required List<CodeBlock> userBlocks,
    required int hintsUsed,
  }) onSubmit;

  const RoomIntroScreen({
    super.key,
    required this.currentRoom,
    required this.onSubmit, 
    required this.currentDungeon,
  });

  @override
  Widget build(BuildContext context) {
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
          currentRoom.name,
          style: AppTextStyles.title,
        ),
        centerTitle: true,
      ),

      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Room type
              Text(
                currentRoom.isBossRoom
                    ? 'Boss Room'
                    : 'Standard Room',
                style: AppTextStyles.subtitle.copyWith(
                  color: currentRoom.isBossRoom
                      ? AppColors.accent
                      : Colors.white70,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Room description
              Text(
                currentRoom.isBossRoom
                    ? 'This room contains multiple challenges.\nExpect tougher logic and fewer hints.'
                    : 'Complete all challenges in this room to progress.',
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Room info cards
              InfoCard(
                title: 'Challenges',
                value: '${currentRoom.challenges.length}',
              ),

              const Spacer(),

              // Enter room
              SizedBox(
                width: double.infinity,
                child: PrimaryActionButton(
                  label: 'ENTER ROOM',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChallengeScreen(currentDungeon: currentDungeon, currentRoom: currentRoom, onSubmit: onSubmit),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
