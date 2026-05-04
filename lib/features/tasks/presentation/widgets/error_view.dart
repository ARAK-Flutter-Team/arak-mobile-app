import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Map error to friendly message
    String title = loc?.somethingWentWrong ?? "Something went wrong";
    String subtitle =
        loc?.unableToLoadTasks ?? "Unable to load tasks. Please try again.";
    IconData icon = Icons.error_outline;

    if (message.contains("500")) {
      subtitle = "Server error. Please try again later.";
      icon = Icons.dns_outlined;
    } else if (message.contains("404")) {
      subtitle = "Tasks not found.";
      icon = Icons.search_off_outlined;
    } else if (message.contains("401") || message.contains("403")) {
      subtitle = "You don't have permission to do this.";
      icon = Icons.lock_outline;
    } else if (message.contains("SocketException") ||
        message.contains("Network") ||
        message.contains("connection")) {
      subtitle = "No internet connection. Check your network.";
      icon = Icons.wifi_off_outlined;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: Colors.red.shade400),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(loc?.tryAgain ?? "Try Again"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
