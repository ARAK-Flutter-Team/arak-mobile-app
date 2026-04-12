import 'package:flutter/material.dart';

class EvaluationSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const EvaluationSaveButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : const Text("Save"),
      ),
    );
  }
}