import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_styles.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/primary_button.dart';

import '../forget_password/forget_password_screen.dart';


class UpdateProfileScreen extends StatefulWidget {
  final String name;
  final String avatar;

  const UpdateProfileScreen(
      {super.key, required this.name, required this.avatar});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final _name = TextEditingController(text: widget.name);
  final _phone = TextEditingController(text: '01200000000');
  late String _avatar = widget.avatar;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _pick() => showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.field,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        builder: (sheet) => GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
          itemCount: AppAssets.avatars.length,
          itemBuilder: (_, i) {
            final a = AppAssets.avatars[i];
            return GestureDetector(
              onTap: () {
                setState(() => _avatar = a);
                Navigator.pop(sheet);
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: a == _avatar
                      ? AppColors.yellow.withValues(alpha: 0.4)
                      : null,
                  border: Border.all(color: AppColors.yellow),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(a, cacheWidth: 300),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.yellow),
        title: Text('Pick Avatar',
            style: AppStyles.link
                .copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  GestureDetector(
                    onTap: _pick,
                    child: ClipOval(
                      child: Image.asset(_avatar,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          cacheWidth: 450),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppTextField(
                      hint: 'Name', icon: AppAssets.name, controller: _name),
                  const SizedBox(height: 16),
                  AppTextField(
                      hint: 'Phone',
                      icon: AppAssets.phone,
                      keyboard: TextInputType.phone,
                      controller: _phone),
                  const SizedBox(height: 16),
  Align(
  alignment: Alignment.centerLeft,
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        ),
      );
    },
    child: const Text(
      'Reset Password',
      style: TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.yellow,
      ),
    ),
  ),
),           
 ]),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Delete Account',
                    style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
              text: 'Update Data',
              style: AppStyles.loginButton,
              onPressed: () => Navigator.pop(context, (_name.text, _avatar)),
            ),
          ]),
        ),
      ),
    );
  }
}