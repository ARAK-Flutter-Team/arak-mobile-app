import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VoicePlayer extends StatefulWidget {

  final String url;

  const VoicePlayer({super.key, required this.url});

  @override
  State<VoicePlayer> createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer> {

  final player = AudioPlayer();
  bool isPlaying = false;

  void toggle() async {

    if (isPlaying) {
      await player.pause();
    } else {
      await player.play(UrlSource(widget.url));
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        IconButton(
          icon: Icon(
            isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
          onPressed: toggle,
        ),

        const Text("Voice message"),
      ],
    );
  }
}