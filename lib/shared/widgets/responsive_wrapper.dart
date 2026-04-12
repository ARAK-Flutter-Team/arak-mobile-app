import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    double maxWidth = 500;

    if (MediaQuery.of(context).size.width > 600) {
      maxWidth = 700;
    }
    if (MediaQuery.of(context).size.width > 1024) {
      maxWidth = 900;
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SafeArea(
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );
  }
}