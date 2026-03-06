import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import '../../domain/entities/message.dart';

class VoiceMessageBubble extends StatefulWidget {
  final Message message;
  final bool isMe;

  const VoiceMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  State<VoiceMessageBubble> createState() => _VoiceMessageBubbleState();
}

class _VoiceMessageBubbleState extends State<VoiceMessageBubble> {
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool isPlaying = false;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    await _player.openPlayer();

    _player.onProgress!.listen((event) {
      setState(() {
        currentPosition = event.position;
      });
    });
  }

  @override
  void dispose() {
    _player.closePlayer();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (isPlaying) {
      await _player.stopPlayer();
      setState(() {
        isPlaying = false;
        currentPosition = Duration.zero;
      });
    } else {
      await _player.startPlayer(
        fromURI: widget.message.fileUrl,
        whenFinished: () {
          setState(() {
            isPlaying = false;
            currentPosition = Duration.zero;
          });
        },
      );

      setState(() {
        isPlaying = true;
      });
    }
  }

  String format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = Duration(seconds: widget.message.duration ?? 0);

    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8, // 👈 المسافة بين الرسائل
        ),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.isMe ? Colors.blue : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// زر التشغيل
            GestureDetector(
              onTap: _togglePlay,
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow, // 👈 يتغير
                color: widget.isMe ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(width: 8),

            /// progress
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                value: totalDuration.inSeconds == 0
                    ? 0
                    : currentPosition.inSeconds / totalDuration.inSeconds,
                backgroundColor: Colors.grey.shade400,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ),
            ),

            const SizedBox(width: 8),

            /// الوقت
            Text(
              isPlaying
                  ? format(currentPosition) // 👈 العداد أثناء التشغيل
                  : format(totalDuration), // 👈 مدة الصوت
              style: TextStyle(
                color: widget.isMe ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}