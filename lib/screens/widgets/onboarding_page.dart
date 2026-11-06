import 'package:flutter/material.dart';
import '../../models/onboarding_model.dart';
import 'card/onboarding_card.dart';
import 'gradient_overlay.dart';
import 'intro/onboarding_intro.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel data;
  final int index;
  final bool isLast;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.index,
    required this.isLast,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
       Image.asset(data.image, fit: BoxFit.cover, cacheWidth: 1000),
        GradientOverlay(gradient: data.gradient),
        Align(
          alignment: Alignment.bottomCenter,
          child: index == 0
              ? OnboardingIntro(data: data, onNext: onNext)
              : OnboardingCard(
                  data: data,
                  isLast: isLast,
                  showBack: index >= 2,
                  onNext: onNext,
                  onBack: onBack,
                ),
        ),
      ],
    );
  }
}