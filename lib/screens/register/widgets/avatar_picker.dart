import 'package:flutter/material.dart';
import '../../../core/app_assets.dart';
import '../../../core/app_styles.dart';

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({super.key});

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  final _avatars = const [
    AppAssets.avatar3,
    AppAssets.avatar1,
    AppAssets.avatar2,
  ];
  int _selected = 1;

  Widget _avatar(int i) {
    final big = i == _selected;
    final size = big ? 150.0 : 90.0;
    return GestureDetector(
      onTap: () => setState(() => _selected = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        child: ClipOval(
          child: Image.asset(_avatars[i], fit: BoxFit.cover, cacheWidth: 450),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(3, _avatar),
        ),
        const SizedBox(height: 8),
        Text('Avatar',
            style: AppStyles.smallText.copyWith(fontSize: 12)),
      ],
    );
  }
}