
import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_spacing.dart';
import '../../core/app_styles.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/auth_link_text.dart';
import '../../core/widgets/language_switch.dart';
import '../../core/widgets/primary_button.dart';
import 'widgets/avatar_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Name Validation
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    final nameRegex = RegExp(
      r"^[a-zA-Z\u0600-\u06FF\s]+$",
    );

    if (!nameRegex.hasMatch(value.trim())) {
      return 'Name must contain letters only';
    }

    return null;
  }

  // Email Validation
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password Validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Add at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Add at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Add at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\\[\];~`]').hasMatch(value)) {
      return 'Add at least one special character';
    }

    return null;
  }

  // Confirm Password Validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Phone Validation
  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    final phoneRegex = RegExp(r'^01[0125][0-9]{8}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid Egyptian phone number';
    }

    return null;
  }

  // Create Account
  void _createAccount() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid.
      // Return to Login Screen.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: AppSpacing.gap);

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.yellow,
        ),
        title: Text(
          'Register',
          style: TextStyle(
            color: AppColors.yellow,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppSpacing.screenPadding,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                const AvatarPicker(),

                gap,

                // Name
                AppTextField(
                  hint: 'Name',
                  icon: AppAssets.name,
                  controller: _nameController,
                  validator: _validateName,
                ),

                gap,

                // Email
                AppTextField(
                  hint: 'Email',
                  icon: AppAssets.email,
                  keyboard: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: _validateEmail,
                ),

                gap,

                // Password
                AppTextField(
                  hint: 'Password',
                  icon: AppAssets.lock,
                  isPassword: true,
                  controller: _passwordController,
                  validator: _validatePassword,
                ),

                gap,

                // Confirm Password
                AppTextField(
                  hint: 'Confirm Password',
                  icon: AppAssets.lock,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                ),

                gap,

                // Phone Number
                AppTextField(
                  hint: 'Phone Number',
                  icon: AppAssets.phone,
                  keyboard: TextInputType.phone,
                  controller: _phoneController,
                  validator: _validatePhone,
                ),

                const SizedBox(height: 24),

                // Create Account
                PrimaryButton(
                  text: 'Create Account',
                  style: AppStyles.loginButton,
                  onPressed: _createAccount,
                ),

                gap,

                AuthLinkText(
                  text: 'Already Have Account ?',
                  link: 'Login',
                  onTap: () => Navigator.pop(context),
                ),

                gap,

                const LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
