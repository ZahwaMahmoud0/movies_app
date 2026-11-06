import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_spacing.dart';
import '../../../core/app_styles.dart';
import '../../../core/widgets/onboarding_title.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../models/onboarding_model.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingModel data;
  final bool isLast;
  final bool showBack;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnboardingCard({
    super.key,
    required this.data,
    required this.isLast,
    required this.showBack,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSpacing.cardRadius)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingTitle(
              title: data.title,
              description: data.description,
              titleStyle: AppStyles.cardTitle,
              descStyle: AppStyles.cardDesc,
            ),
            const SizedBox(height: AppSpacing.gapLarge),
            PrimaryButton(text: isLast ? 'Finish' : 'Next', onPressed: onNext),
            if (showBack) ...[
              const SizedBox(height: AppSpacing.gap),
              SecondaryButton(text: 'Back', onPressed: onBack),
            ],
          ],
        ),
      ),
    );
  }
}