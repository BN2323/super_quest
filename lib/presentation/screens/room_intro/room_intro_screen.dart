import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/room.dart';
import 'package:super_quest/presentation/screens/challenge/challenge_screen.dart';
import 'package:super_quest/presentation/widgets/buttons/primary_action_button.dart';
import 'package:super_quest/presentation/widgets/cards/info_card.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_spacing.dart';

class RoomIntroScreen extends StatelessWidget {
  final Room room;

  const RoomIntroScreen({
    super.key,
    required this.room,
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
          room.name,
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
                room.isBossRoom
                    ? 'Boss Room'
                    : 'Standard Room',
                style: AppTextStyles.subtitle.copyWith(
                  color: room.isBossRoom
                      ? AppColors.accent
                      : Colors.white70,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Room description
              Text(
                room.isBossRoom
                    ? 'This room contains multiple challenges.\nExpect tougher logic and fewer hints.'
                    : 'Complete all challenges in this room to progress.',
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Room info cards
              InfoCard(
                title: 'Challenges',
                value: '${room.challenges.length}',
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
                        builder: (_) => ChallengeScreen(room: room),
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
