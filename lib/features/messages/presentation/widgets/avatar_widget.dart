import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String url;
  final double radius;

  const AvatarWidget({
    super.key,
    required this.url,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(url),
      backgroundColor: Colors.grey.shade200,
    );
  }
}