/*import 'package:flutter/material.dart';

class MessageTime extends StatelessWidget {

  final DateTime time;
  final bool isMe;

  const MessageTime({
    super.key,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {

    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    final formatted = "$hour:$minute";

    return Text(
      formatted,
      style: TextStyle(
        fontSize: 11,
        color: isMe
            ? Colors.white70
            : Colors.black54,
      ),
    );
  }
}*/
import 'package:flutter/material.dart';

class MessageTime extends StatelessWidget {

  final DateTime time;
  final bool isMe;

  const MessageTime({
    super.key,
    required this.time,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {

    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    final formatted = "$hour:$minute";

    return Text(
      formatted,
      style: TextStyle(
        fontSize: 11,
        color: isMe
            ? Colors.white70
            : Colors.black54,
      ),
    );
  }
}