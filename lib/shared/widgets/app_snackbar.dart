import 'package:flutter/material.dart';

enum AppSnackBarType { success, error, warning, info }

class AppSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        AppSnackBarType type = AppSnackBarType.info,
      }) {
    final theme = Theme.of(context);

    Color backgroundColor;
    IconData icon;

    switch (type) {
      case AppSnackBarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case AppSnackBarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case AppSnackBarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      case AppSnackBarType.info:
        backgroundColor = theme.colorScheme.primary;
        icon = Icons.info;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed, // 👈 مهم
        backgroundColor: backgroundColor,
        elevation: 8,
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}