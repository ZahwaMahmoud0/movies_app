import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // مشترك
  static const TextStyle button = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 20,
  );

  // بوردنج 1
  static const TextStyle introTitle = TextStyle(
    color: AppColors.white,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );
  static final TextStyle introDesc = TextStyle(
    color: AppColors.white.withValues(alpha: 0.6),
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 24 / 16,
  );

  // بوردنج 2 → 6
  static const TextStyle cardTitle = TextStyle(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1,
  );
  static const TextStyle cardDesc = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  // Splash
  static const TextStyle splashSupervisor = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 38 / 16,
  );
    // Auth
  static const TextStyle hint = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
 
  
    static const TextStyle loginButton = TextStyle(
    color: AppColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle smallText = GoogleFonts.roboto(
  color: AppColors.white,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  height: 1.2,
);

static final TextStyle link = GoogleFonts.roboto(
  color: AppColors.yellow,
  fontSize: 14,
  fontWeight: FontWeight.w900,
  height: 1.2,
);

}