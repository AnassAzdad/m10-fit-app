import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/language_toggle.dart';

import '../pillars/pillars_screen.dart';
import '../checkin/checkin_screen.dart';
import '../notes/notes_screen.dart';
import '../help/help_screen.dart';
import '../quotes/quotes_screen.dart';
import '../challenges/challenges_screen.dart';

import '../../core/stats_service.dart';

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
      OverviewTab(
        key: ValueKey('overview-$index'),
        onNavigate: _navigateTo,
      ),
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final scaffold = Scaffold(
                backgroundColor: Colors.transparent,

                appBar: AppBar(
                  title: Text(L.t('app_title', lang)),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: Colors.white,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                  actions: [
                    LanguageToggle(onChanged: () => setState(() {})),
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
              );

              // 📱 Mobiel → fullscreen
              if (!kIsWeb || width < 600) {
                return scaffold;
              }

              // 💻 Web / desktop → phone frame
              return Center(
                child: _PhoneFrame(child: scaffold),
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateTo(String target) {
    if (target == 'pillars') {
      setState(() => index = 1);
      return;
    }
    if (target == 'checkin') {
      setState(() => index = 2);
      return;
    }
    if (target == 'notes') {
      setState(() => index = 3);
      return;
    }
    if (target == 'help') {
      setState(() => index = 4);
      return;
    }
    if (target == 'quotes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const QuotesScreen()),
      );
      return;
    }
    if (target == 'challenges') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ChallengesScreen()),
      );
      return;
    }
  }
}

/* ================= PHONE FRAME ================= */

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
            border: Border.all(color: Colors.white.withOpacity(0.12)),
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

/* ================= OVERVIEW TAB ================= */

class OverviewTab extends StatefulWidget {
  final void Function(String target) onNavigate;
  const OverviewTab({super.key, required this.onNavigate});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  bool loading = true;
  CheckinStats? stats;
  List<LeaderboardRow> leaderboard = [];
  String? err;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant OverviewTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    _load();
  }

  Future<void> _load() async {
    final user = AppState.currentUser;
    if (user == null) return;

    setState(() {
      loading = true;
      err = null;
    });

    try {
      final today = DateTime.now();
      final s = await StatsService.getTodayStats(
        day: today,
        opleiding: user.opleiding,
      );
      final lb = await StatsService.getTodayLeaderboard(day: today);

      if (!mounted) return;
      setState(() {
        stats = s;
        leaderboard = lb.take(6).toList();
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        err = 'stats_error';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;
    final user = AppState.currentUser;

    final name = user?.name ?? L.t('student', lang);
    final opleiding = user?.opleiding ?? '';
    final klas = user?.klas ?? '';

    final totalToday = stats?.totalToday ?? 0;
    final opleidingToday = stats?.opleidingToday ?? 0;
    final ratio =
        totalToday == 0 ? 0.0 : (opleidingToday / totalToday).clamp(0.0, 1.0);

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${L.t('welcome', lang)}, $name 👋',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            L.t('how_feel', lang),
            style: TextStyle(color: Colors.white.withOpacity(0.8)),
          ),
          const SizedBox(height: 16),

          // Stats
          if (loading)
            const Center(child: CircularProgressIndicator())
          else ...[
            Text(
              '${L.t('today', lang)}: $opleidingToday / $totalToday',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: ratio,
              backgroundColor: const Color(0xFF141A2E),
              valueColor:
                  const AlwaysStoppedAnimation(Color(0xFF00F5FF)),
            ),
          ],

          const SizedBox(height: 24),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _HomeTile(
                icon: Icons.grid_view,
                label: L.t('pillars', lang),
                color: const Color(0xFF00F5FF),
                onTap: () => widget.onNavigate('pillars'),
              ),
              _HomeTile(
                icon: Icons.favorite,
                label: L.t('checkin', lang),
                color: const Color(0xFFFF4B91),
                onTap: () => widget.onNavigate('checkin'),
              ),
              _HomeTile(
                icon: Icons.flag,
                label: L.t('challenges', lang),
                color: const Color(0xFFFFD166),
                onTap: () => widget.onNavigate('challenges'),
              ),
              _HomeTile(
                icon: Icons.help_outline,
                label: L.t('help', lang),
                color: const Color(0xFF00C2FF),
                onTap: () => widget.onNavigate('help'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ================= HOME TILE ================= */

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _HomeTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
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
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
