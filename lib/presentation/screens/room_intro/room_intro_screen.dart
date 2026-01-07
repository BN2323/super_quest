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
    final challenge = room.challenge;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Room title
              Text(
                room.name,
                style: AppTextStyles.title,
              ),

              const SizedBox(height: AppSpacing.sm),

              // Challenge description
              Text(
                challenge.description,
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Challenge type
              InfoCard(
                title: 'Challenge Type',
                value: challenge.type.name,
              ),

              const SizedBox(height: AppSpacing.sm),

              // Hint info
              InfoCard(
                title: 'Hints Available',
                value: '${challenge.maxHints}',
              ),

              const SizedBox(height: AppSpacing.sm),

              // Star rules
              const InfoCard(
                title: 'Stars',
                value: '3★ No hints • 2★ 1 hint • 1★ 2 hints',
              ),

              const SizedBox(height: AppSpacing.md),

              // Retry reassurance
              Text(
                'You can retry this challenge anytime. Only your best result is saved.',
                style: AppTextStyles.subtitle,
              ),

              const Spacer(),

              // Start challenge button
              PrimaryActionButton(
                label: 'START CHALLENGE',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChallengeScreen(room: room),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}