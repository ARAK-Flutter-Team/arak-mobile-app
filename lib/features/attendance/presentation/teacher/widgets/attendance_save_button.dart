import 'package:flutter/material.dart';

class AttendanceSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AttendanceSaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text("Save Attendance"),
        ),
      ),
    );
  }
}