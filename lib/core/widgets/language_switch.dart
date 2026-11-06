import 'package:flutter/material.dart';
import '../app_assets.dart';
import '../app_colors.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  bool _isEnglish = true;

  static const double _w = 90.72;
  static const double _h = 38.08;
  static const double _border = 2.5;
  static const double _knob = _h - _border * 2;
  static const double _flag = 24;

  Widget _flagImage(String asset) => ClipOval(
        child: Image.asset(asset,
            width: _flag, height: _flag, fit: BoxFit.cover, cacheWidth: 96),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isEnglish = !_isEnglish),
      child: Container(
        width: _w,
        height: _h,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(_h),
          border: Border.all(color: AppColors.yellow, width: _border),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: _flagImage(AppAssets.us),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: _flagImage(AppAssets.eg),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment:
                  _isEnglish ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: _knob,
                height: _knob,
                decoration: const BoxDecoration(
                  color: AppColors.yellow,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: _flagImage(_isEnglish ? AppAssets.us : AppAssets.eg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}