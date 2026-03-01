import 'package:flutter/material.dart';

class AppColors {
  // 🔵 ألوان ثابتة (Brand)
  static const Color strokeColor = Color(0xFF42B0FF);
  static const Color red = Color(0xFFED1A1A);
  static const Color primaryBlue = Color(0xFF1877F2);
  static const Color green = Color(0xFF41F87E);
  static const Color orange = Color(0xFFE89D25);

  // 🎨 ألوان ديناميكية حسب الثيم

  static Color background(BuildContext context) =>
      Theme.of(context).colorScheme.background;

  static Color surface(BuildContext context) =>
      Theme.of(context).colorScheme.surface;

  static Color primary(BuildContext context) =>
      Theme.of(context).colorScheme.primary;

  static Color secondary(BuildContext context) =>
      Theme.of(context).colorScheme.secondary;

  static Color textPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onBackground;

  static Color textOnPrimary(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;

  static Color error(BuildContext context) =>
      Theme.of(context).colorScheme.error;
}