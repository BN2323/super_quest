import 'package:flutter/material.dart';
import 'package:super_quest/domain/models/room.dart';
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

              // Room description (from challenge)
              Text(
                room.challenge.description,
                style: AppTextStyles.subtitle,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Room meta info
              InfoCard(
                title: 'Challenge Type',
                value: room.challenge.type.name,
              ),

              const SizedBox(height: AppSpacing.sm),

              InfoCard(
                title: 'Max Attempts',
                value: room.challenge.maxAttempts.toString(),
              ),

              const Spacer(),

              // Start challenge button
              PrimaryActionButton(
                label: 'START CHALLENGE',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ChallengeScreen(room: room),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
