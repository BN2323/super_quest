import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // ===== HEADINGS =====
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  // ===== BODY =====
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  // ===== BUTTON =====
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  // ===== SMALL LABELS =====
  static const TextStyle label = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}
