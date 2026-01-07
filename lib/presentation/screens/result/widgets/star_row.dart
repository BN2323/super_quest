import 'package:flutter/material.dart';
import 'package:super_quest/presentation/theme/app_colors.dart';

class StarRow extends StatelessWidget {
  final int count;

  const StarRow(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            Icons.star,
            size: 28,
            color: i < count
                ? AppColors.accent
                : AppColors.textDisabled,
          ),
        );
      }),
    );
  }
}
