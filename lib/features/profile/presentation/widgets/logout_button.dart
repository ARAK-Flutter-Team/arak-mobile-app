import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final confirm = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: theme.dialogBackgroundColor,
              title: Text(
                loc.confirmLogout,
                style: TextStyle(color: theme.colorScheme.onBackground),
              ),
              content: Text(
                loc.logoutMessage,
                style: TextStyle(color: theme.colorScheme.onBackground),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    loc.cancel,
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    loc.logout,
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              ],
            ),
          );

          if (confirm == true) {
            await ref.read(authProvider.notifier).logout();
            context.go('/login');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
        ),
        child: Text(loc.logout),
      ),
    );
  }
}
