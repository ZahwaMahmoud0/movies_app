import 'package:flutter/material.dart';
import '../core/app_assets.dart';
import '../models/onboarding_model.dart';

Gradient _grad(Color c) => LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [c.withValues(alpha: 0), c],
    );

final List<OnboardingModel> onboardingList = [
  const OnboardingModel(
    image: AppAssets.onboarding1,
    title: 'Find Your Next\nFavorite Movie Here',
    description:
        'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 0.39, 0.675, 1.0],
      colors: [
        Color(0x001E1E1E),
        Color(0x80121312),
        Color(0xE8121312),
        Color(0xFF121312),
      ],
    ),
  ),
  OnboardingModel(
    image: AppAssets.onboarding2,
    title: 'Discover Movies',
    description:
        'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    gradient: _grad(const Color(0xFF084250)),
  ),
  OnboardingModel(
    image: AppAssets.onboarding3,
    title: 'Explore All Genres',
    description:
        'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    gradient: _grad(const Color(0xFF85210E)),
  ),
  OnboardingModel(
    image: AppAssets.onboarding4,
    title: 'Create Watchlists',
    description:
        'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    gradient: _grad(const Color(0xFF4C2471)),
  ),
  OnboardingModel(
    image: AppAssets.onboarding5,
    title: 'Rate, Review, and Learn',
    description:
        'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
    gradient: _grad(const Color(0xFF601321)),
  ),
  OnboardingModel(
    image: AppAssets.onboarding6,
    title: 'Start Watching Now',
    description: '',
    gradient: _grad(const Color(0xFF2A2C30)),
  ),
];