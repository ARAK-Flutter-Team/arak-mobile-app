import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class VoiceRecordingWidget extends StatefulWidget {

  final Duration duration;
  final VoidCallback onDelete;
  final VoidCallback onSend;

  const VoiceRecordingWidget({
    super.key,
    required this.duration,
    required this.onDelete,
    required this.onSend,
  });

  @override
  State<VoiceRecordingWidget> createState() => _VoiceRecordingWidgetState();
}

class _VoiceRecordingWidgetState extends State<VoiceRecordingWidget> {

  final List<double> bars = List.generate(20, (_) => Random().nextDouble());

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 200),
          (_) {
        setState(() {
          for (int i = 0; i < bars.length; i++) {
            bars[i] = Random().nextDouble();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String format(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        /// Timer
        Text(
          format(widget.duration),
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(width: 10),

        /// Wave animation
        Expanded(
          child: Row(
            children: bars.map((v) {

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: 3,
                height: 20 + (v * 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(2),
                ),
              );

            }).toList(),
          ),
        ),

        /// Delete
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: widget.onDelete,
        ),

        /// Send
        IconButton(
          icon: const Icon(Icons.send, color: Colors.blue),
          onPressed: widget.onSend,
        ),

      ],
    );
  }
}