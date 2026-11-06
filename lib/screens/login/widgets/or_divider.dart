import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/app_styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    const line = Expanded(
      child: Divider(color: AppColors.yellow, thickness: 1),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56),
      child: Row(
        children: [
          line,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text('OR', style: AppStyles.link.copyWith(fontSize: 12)),
          ),
          line,
        ],
      ),
    );
  }
}