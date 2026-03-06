import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onPickImage;

  const ImageButton({super.key, required this.onPickImage});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset("assets/icons/Image fill.svg", width: 22),
      onPressed: onPickImage,
    );
  }
}