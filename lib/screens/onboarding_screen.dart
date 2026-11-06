import 'package:flutter/material.dart';
import '../data/onboarding_data.dart';
import 'login/login_screen.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  final _duration = const Duration(milliseconds: 400);

  void _next(int index) {
    if (index == onboardingList.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }
    _controller.nextPage(duration: _duration, curve: Curves.easeInOut);
  }

  void _back() =>
      _controller.previousPage(duration: _duration, curve: Curves.easeInOut);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingList.length,
        itemBuilder: (_, i) => OnboardingPage(
          data: onboardingList[i],
          index: i,
          isLast: i == onboardingList.length - 1,
          onNext: () => _next(i),
          onBack: _back,
        ),
      ),
    );
  }
}