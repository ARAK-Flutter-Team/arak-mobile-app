import 'package:flutter/material.dart';

class AttendanceSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AttendanceSaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text("Save Attendance"),
      ),
    );
  }
}