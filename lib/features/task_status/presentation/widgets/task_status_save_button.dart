import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class TaskStatusSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const TaskStatusSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(loc.save),
      ),
    );
  }
}