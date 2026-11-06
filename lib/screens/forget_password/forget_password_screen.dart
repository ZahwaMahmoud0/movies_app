import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_spacing.dart';
import '../../core/app_styles.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.yellow),
        title: Text(
          'Forget Password',
          style: AppStyles.link.copyWith(fontWeight: FontWeight.w400),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            children: [
              Image.asset(
                AppAssets.forgetPassword,
                width: double.infinity,
                height: 340,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: AppSpacing.gapLarge),
              const AppTextField(
                hint: 'Email',
                icon: AppAssets.email,
                keyboard: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.gapLarge),
              PrimaryButton(
                text: 'Verify Email',
                style: AppStyles.loginButton,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}