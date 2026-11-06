import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../profile/profile_screen.dart';
import 'home_tab.dart';
import '../browse/browse_tab.dart';
import '../search/search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  final _visited = {0};

  // كل أيقونة: (غير نشطة، نشطة)
  static const _icons = [
    ('assets/icons/home.png', 'assets/icons/home_active.png'),
    ('assets/icons/search.png', 'assets/icons/search_active.png'),
    ('assets/icons/browse.png', 'assets/icons/browse_active.png'),
    ('assets/icons/profile.png', 'assets/icons/profile_active.png'),
  ];

  // الترتيب لازم يطابق ترتيب الأيقونات
  final _pages = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: IndexedStack(
        index: _tab,
        children: List.generate(
          _pages.length,
          (i) => _visited.contains(i) ? _pages[i] : const SizedBox(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.only(bottom: 8),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.field,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (i) {
              final active = i == _tab;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() {
                  _tab = i;
                  _visited.add(i);
                }),
                child: Image.asset(
                  active ? _icons[i].$2 : _icons[i].$1,
                  width: 24,
                  height: 24,
                  cacheWidth: 72,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}