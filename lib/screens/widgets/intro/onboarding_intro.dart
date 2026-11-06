import 'package:flutter/material.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_styles.dart';
import '../../../core/widgets/onboarding_title.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../models/onboarding_model.dart';

class OnboardingIntro extends StatelessWidget {
  final OnboardingModel data;
  final VoidCallback onNext;

  const OnboardingIntro({super.key, required this.data, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding,
          0,
          AppSpacing.screenPadding,
          24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingTitle(
              title: data.title,
              description: data.description,
              titleStyle: AppStyles.introTitle,
              descStyle: AppStyles.introDesc,
              descMaxWidth: 364,
            ),
            const SizedBox(height: AppSpacing.gapLarge),
            PrimaryButton(text: 'Explore Now', onPressed: onNext),
          ],
        ),
      ),
    );
  }
}