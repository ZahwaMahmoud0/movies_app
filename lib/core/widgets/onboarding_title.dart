import 'package:flutter/material.dart';
import '../app_spacing.dart';

class OnboardingTitle extends StatelessWidget {
  final String title;
  final String description;
  final TextStyle titleStyle;
  final TextStyle descStyle;
  final double? descMaxWidth;

  const OnboardingTitle({
    super.key,
    required this.title,
    required this.description,
    required this.titleStyle,
    required this.descStyle,
    this.descMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, textAlign: TextAlign.center, style: titleStyle),
        if (description.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.gap),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: descMaxWidth ?? double.infinity),
            child: Text(description,
                textAlign: TextAlign.center, style: descStyle),
          ),
        ],
      ],
    );
  }
}