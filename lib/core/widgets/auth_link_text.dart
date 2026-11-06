import 'package:flutter/material.dart';
import '../app_styles.dart';

class AuthLinkText extends StatelessWidget {
  final String text;
  final String link;
  final VoidCallback onTap;

  const AuthLinkText({
    super.key,
    required this.text,
    required this.link,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$text ', style: AppStyles.smallText),
        GestureDetector(
          onTap: onTap,
          child: Text(link, style: AppStyles.link),
        ),
      ],
    );
  }
}