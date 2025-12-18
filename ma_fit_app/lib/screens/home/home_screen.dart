import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/language_toggle.dart';
import '../pillars/pillars_screen.dart';
import '../checkin/checkin_screen.dart';
import '../notes/notes_screen.dart';
import '../help/help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

   final pages = [
  const OverviewTab(),
  PillarsScreen(key: ValueKey(AppState.language)),
  CheckInScreen(key: ValueKey(AppState.language)),
  NotesScreen(key: ValueKey(AppState.language)),
  HelpScreen(key: ValueKey(AppState.language)),
];


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050816), Color(0xFF09041A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: _PhoneFrame(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(L.t('app_title', lang)),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    LanguageToggle(
                      onChanged: () => setState(() {}),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        AppState.logoutUser();
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                    ),
                  ],
                ),
                body: pages[index],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: index,
                  onTap: (i) => setState(() => index = i),
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.home),
                      label: L.t('home', lang),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.grid_view),
                      label: L.t('pillars', lang),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.favorite),
                      label: L.t('checkin', lang),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.edit),
                      label: L.t('notes', lang),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.help_outline),
                      label: L.t('help', lang),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneFrame extends StatelessWidget {
  final Widget child;
  const _PhoneFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 420,
        maxHeight: 900,
      ),
      child: AspectRatio(
        aspectRatio: 9 / 19.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.55),
                blurRadius: 28,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: child,
          ),
        ),
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;
    final user = AppState.currentUser;
    final name = user?.name ?? L.t('student', lang);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F1535), Color(0xFF080A1A)],
            ),
            border: Border.all(
              color: const Color(0xFF00F5FF).withOpacity(0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${L.t('welcome', lang)}, $name 👋',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                L.t('how_feel', lang),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
          children: [
            _HomeTile(
              icon: Icons.grid_view,
              label: L.t('pillars', lang),
              color: const Color(0xFF00F5FF),
            ),
            _HomeTile(
              icon: Icons.favorite,
              label: L.t('checkin', lang),
              color: const Color(0xFFFF4B91),
            ),
            _HomeTile(
              icon: Icons.edit,
              label: L.t('notes', lang),
              color: const Color(0xFF9B5CFF),
            ),
            _HomeTile(
              icon: Icons.flag,
              label: L.t('challenges', lang),
              color: const Color(0xFFFFD166),
            ),
            _HomeTile(
              icon: Icons.format_quote,
              label: L.t('quotes', lang),
              color: const Color(0xFF6EEB83),
            ),
            _HomeTile(
              icon: Icons.help_outline,
              label: L.t('help', lang),
              color: const Color(0xFF00C2FF),
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _HomeTile({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xFF0C1120),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
