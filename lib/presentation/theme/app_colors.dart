import 'package:flutter/material.dart';

class AppColors {
  // ===== BACKGROUND =====
  static const Color background = Color(0xFF1B1A2F); // dungeon purple
  static const Color surface = Color(0xFF262544); // cards / panels

  // ===== PRIMARY ACTION =====
  static const Color primary = Color(0xFF6C63FF); // magic purple
  static const Color primaryShadow = Color(0xFF4B45C6);

  // ===== ACCENT / REWARD =====
  static const Color accent = Color(0xFFFFC857); // gold
  static const Color accentShadow = Color(0xFFD9A441);

  // ===== FEEDBACK =====
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFFF5C5C);

  // ===== TEXT =====
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textDisabled = Colors.white38;

  // ===== ROOM STATES =====
  static const Color roomLocked = Color(0xFF3A3A55);
  static const Color roomUnlocked = primary;
  static const Color roomCompleted = success;
}
