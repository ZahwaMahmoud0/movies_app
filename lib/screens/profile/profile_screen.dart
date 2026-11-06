import 'package:flutter/material.dart';
import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/movie_card.dart';
import '../../models/movie_model.dart';
import '../../services/movies_api.dart';
import '../login/login_screen.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Safwat';
  String _avatar = AppAssets.avatars[0];
  final List<MovieModel> _watch = [];
  List<MovieModel> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final m = await MoviesApi.getMovies(limit: 12);
      if (mounted) setState(() => _history = m);
    } catch (_) {}
  }

  Future<void> _edit() async {
    final r = await Navigator.push<(String, String)>(
      context,
      MaterialPageRoute(
          builder: (_) => UpdateProfileScreen(name: _name, avatar: _avatar)),
    );
    if (r != null) {
      setState(() {
        _name = r.$1;
        _avatar = r.$2;
      });
    }
  }

  void _exit() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (_) => false,
      );

  Widget _stat(int n, String label) {
    const s = TextStyle(color: AppColors.white, fontWeight: FontWeight.w700);
    return Column(children: [
      Text('$n', style: s.copyWith(fontSize: 24)),
      Text(label, style: s.copyWith(fontSize: 16)),
    ]);
  }

  Widget _btn(String t, Color bg, Color fg, VoidCallback onTap,
          {int flex = 1, IconData? icon}) =>
      Expanded(
        flex: flex,
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: bg,
              foregroundColor: fg,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(t, style: const TextStyle(fontWeight: FontWeight.w500)),
              if (icon != null) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 18),
              ],
            ]),
          ),
        ),
      );

  Widget _grid(List<MovieModel> m) => m.isEmpty
      ? Center(
          child: Image.asset(AppAssets.empty,
              width: 120,
              cacheWidth: 360,
              errorBuilder: (_, _, _) => const Icon(Icons.local_movies,
                  size: 90, color: AppColors.yellow)))
      : GridView.builder(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.68),
          itemCount: m.length,
          itemBuilder: (_, i) => MovieCard(movie: m[i]),
        );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(children: [
              Row(children: [
                ClipOval(
                  child: Image.asset(_avatar,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      cacheWidth: 300),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _stat(_watch.length, 'Wish List'),
                      _stat(_history.length, 'History'),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_name,
                    style: const TextStyle(
                        color: AppColors.white, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 12),
              Row(children: [
                _btn('Edit Profile', AppColors.yellow, AppColors.black, _edit,
                    flex: 2),
                const SizedBox(width: 12),
                _btn('Exit', AppColors.red, AppColors.white, _exit,
                    icon: Icons.logout),
              ]),
            ]),
          ),
          const TabBar(
            indicatorColor: AppColors.yellow,
            labelColor: AppColors.yellow,
            unselectedLabelColor: AppColors.white,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Watch List'),
              Tab(icon: Icon(Icons.folder), text: 'History'),
            ],
          ),
          Expanded(
            child: TabBarView(children: [_grid(_watch), _grid(_history)]),
          ),
        ]),
      ),
    );
  }
}