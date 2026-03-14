import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/providers/current_user_provider.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: theme.dialogBackgroundColor,
              title: Text(
                "Confirm Logout",
                style: TextStyle(color: theme.colorScheme.onBackground),
              ),
              content: Text(
                "Are you sure you want to log out?",
                style: TextStyle(color: theme.colorScheme.onBackground),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "Logout",
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              ],
            ),
          );

          if (confirm == true) {
            // مسح بيانات المستخدم
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();

            // تحديث provider
            ref.read(currentUserProvider.notifier).state = null;

            // الرجوع لصفحة تسجيل الدخول
            context.go('/login');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
        ),
        child: const Text("Logout"),
      ),
    );
  }
}