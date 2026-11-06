import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../models/onboarding_model.dart';

class OnboardingTexts extends StatelessWidget {
  final OnboardingModel data;
  final double titleSize;
  final FontWeight titleWeight;
  final double descSize;
  final double descHeight;
  final double descOpacity;
  final double? descWidth;

  const OnboardingTexts({
    super.key,
    required this.data,
    required this.titleSize,
    this.titleWeight = FontWeight.w700,
    this.descSize = 14,
    this.descHeight = 1.3,
    this.descOpacity = 1,
    this.descWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: titleSize,
            fontWeight: titleWeight,
            height: 1.2,
          ),
        ),
        if (data.description.isNotEmpty) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: descWidth ?? double.infinity),
            child: Text(
              data.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white.withValues(alpha: descOpacity),
                fontSize: descSize,
                fontWeight: FontWeight.w400,
                height: descHeight,
              ),
            ),
          ),
        ],
      ],
    );
  }
}