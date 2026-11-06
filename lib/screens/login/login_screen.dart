
import 'package:flutter/material.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_spacing.dart';
import '../../core/app_styles.dart';
import '../../core/widgets/auth_link_text.dart';
import '../../core/widgets/language_switch.dart';
import '../../core/widgets/primary_button.dart';

import 'widgets/google_button.dart';
import '../register/register_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../home/home_screen.dart'; // عدلي المسار حسب مكان الملف

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  void login() {
    if (_formKey.currentState!.validate()) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const gap = SizedBox(height: AppSpacing.gap);

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),

          child: Form(
            key: _formKey,

            child: Column(
              children: [

                const SizedBox(height: 30),

                Image.asset(
                  AppAssets.logo,
                  width: 200,
                  height: 200,
                ),

                // Email Field
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Image.asset(
                      AppAssets.email,
                      width: 24,
                      height: 24,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$',
                    );

                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                gap,

                // Password Field
                TextFormField(
                  controller: passwordController,
                  obscureText: true,

                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Image.asset(
                      AppAssets.lock,
                      width: 24,
                      height: 24,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                ),

                Align(
                  alignment: Alignment.centerRight,

                  child: TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ForgetPasswordScreen(),
                      ),
                    ),

                    child: Text(
                      'Forget Password ?',
                      style: AppStyles.link,
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                PrimaryButton(
                  text: 'Login',
                  style: AppStyles.loginButton,
                  onPressed: login,
                ),

                const SizedBox(height: 25),

                AuthLinkText(
                  text: "Don't Have Account ?",
                  link: 'Create One',

                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  ),
                ),

                gap,

                const OrDivider(),

                gap,

                GoogleButton(onPressed: () {}),

                gap,

                const SizedBox(height: 10),

                const LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {

    const line = Expanded(
      child: Divider(
        color: AppColors.yellow,
        thickness: 1,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56),

      child: Row(
        children: [
          line,

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'OR',
              style: AppStyles.link,
            ),
          ),

          line,
        ],
      ),
    );
  }
}
