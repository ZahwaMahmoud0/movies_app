import 'package:flutter/material.dart';

class GradientOverlay extends StatelessWidget {
  final Gradient gradient;

  const GradientOverlay({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: DecoratedBox(decoration: BoxDecoration(gradient: gradient)),
    );
  }
}