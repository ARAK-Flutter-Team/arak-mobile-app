/*import 'package:flutter/material.dart';
class AppColors {
  static const Color white = Color(0xFFFFFFFF);

  // 👇 الخلفية الرسمية للـ Light Mode
  static const Color background = Color(0xFFFFFFFF);

  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF0B2545);
  static const Color gray = Color(0xFF747B85);
  static const Color strokeColor = Color(0xFF42B0FF);
  static const Color coloredFilled = Color(0xFFF5F5F5);
  static const Color red = Color(0xFFED1A1A);
  static const Color primaryBlue = Color(0xFF1877F2);
  static const Color green = Color(0xFF41F87E);
  static const Color orange = Color(0xFFE89D25);
}*/
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