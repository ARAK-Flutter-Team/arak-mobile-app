/*import 'package:flutter/material.dart';

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
}*/
import 'package:flutter/material.dart';

enum AppSnackBarType { success, error, warning, info }

class AppSnackBar {
  static void show(
      BuildContext context, {
        required String message,
        AppSnackBarType type = AppSnackBarType.info,
      }) {
    final theme = Theme.of(context);

    Color color;
    IconData icon;

    switch (type) {
      case AppSnackBarType.success:
        color = const Color(0xff22c55e);
        icon = Icons.check_circle_rounded;
        break;

      case AppSnackBarType.error:
        color = const Color(0xffef4444);
        icon = Icons.error_rounded;
        break;

      case AppSnackBarType.warning:
        color = const Color(0xfff59e0b);
        icon = Icons.warning_rounded;
        break;

      case AppSnackBarType.info:
        color = const Color(0xff3b82f6);
        icon = Icons.info_rounded;
        break;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: color.withOpacity(.25),
            width: 1,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 18,
              offset: const Offset(0, 6),
            )
          ],
        ),

        child: Row(
          children: [

            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: Icon(
                Icons.close,
                size: 18,
                color: theme.iconTheme.color?.withOpacity(.6),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}