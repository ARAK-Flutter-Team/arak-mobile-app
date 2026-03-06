import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {

  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: const [

        SizedBox(width: 8),

        Text(
          "Typing...",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}