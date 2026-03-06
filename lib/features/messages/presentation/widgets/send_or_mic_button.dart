import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SendOrMicButton extends StatelessWidget {
  final bool hasText;
  final bool isRecording;
  final Duration recordingDuration;

  final VoidCallback onSend;
  final VoidCallback onRecord;
  final VoidCallback onCancelRecording;

  const SendOrMicButton({
    super.key,
    required this.hasText,
    required this.isRecording,
    required this.recordingDuration,
    required this.onSend,
    required this.onRecord,
    required this.onCancelRecording,
  });

  String formatDuration(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    return "${two(d.inMinutes)}:${two(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {

    /// TEXT MESSAGE
    if (hasText && !isRecording) {
      return IconButton(
        icon: SvgPicture.asset(
          "assets/icons/Frame.svg",
          width: 24,
          height: 24,
        ),
        onPressed: onSend,
      );
    }

    /// RECORDING STATE
    if (isRecording) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// TIMER
          Text(
            formatDuration(recordingDuration),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 8),

          /// TRASH BUTTON
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: onCancelRecording,
          ),

          /// SEND RECORDING
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/Frame.svg",
              width: 24,
              height: 24,
            ),
            onPressed: onSend,
          ),
        ],
      );
    }

    /// MIC BUTTON
    return IconButton(
      icon: SvgPicture.asset(
        "assets/icons/microphone.svg",
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          Color(0xFF007AFF),
          BlendMode.srcIn,
        ),
      ),
      onPressed: onRecord,
    );
  }
}