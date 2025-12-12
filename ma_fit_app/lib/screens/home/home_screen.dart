import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/language_toggle.dart';
import '../../widgets/primary_card.dart';
import '../pillars/pillars_screen.dart';
import '../checkin/checkin_screen.dart';
import '../notes/notes_screen.dart';
import '../help/help_screen.dart';
import '../challenges/challenges_screen.dart';
import '../quotes/quotes_screen.dart';

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
      OverviewTab(onNavigate: _navigateTo),
      const PillarsScreen(),
      const CheckInScreen(),
      const NotesScreen(),
      const HelpScreen(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(L.t('app_title', lang)),
        backgroundColor: Colors.transparent,
        actions: [
          LanguageToggle(
            onChanged: () {
              setState(() {});
            },
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF050816),
              Color(0xFF09041A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: pages[index],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: L.t('home_tab_overview', lang),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.grid_view),
            label: L.t('home_tab_pillars', lang),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: L.t('home_tab_checkin', lang),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit),
            label: L.t('home_tab_notes', lang),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.help_outline),
            label: L.t('home_tab_more', lang),
          ),
        ],
      ),
    );
  }

  void _navigateTo(String target) {
    if (target == 'pillars') index = 1;
    else if (target == 'checkin') index = 2;
    else if (target == 'notes') index = 3;
    else if (target == 'help') index = 4;
    else if (target == 'challenges') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChallengesScreen()));
      return;
    } else if (target == 'quotes') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const QuotesScreen()));
      return;
    }

    setState(() {});
  }
}

class OverviewTab extends StatelessWidget {
  final void Function(String target) onNavigate;

  const OverviewTab({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser;
    final lang = AppState.language;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0F1535),
                Color(0xFF080A1A),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF00F5FF).withOpacity(0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00F5FF).withOpacity(0.25),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welkom terug, ${user?.name ?? 'Student'} 👋",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              if (user != null)
                Text(
                  '${user.opleiding} · ${user.klas}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              const SizedBox(height: 12),
              Text(
                "Fijn dat je er weer bent.\nHoe voel je je vandaag?",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Je staat er niet alleen voor. MA Fit helpt je elke dag een beetje verder.",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Jouw tools",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.95,
          children: [
            FeatureTile(
              icon: Icons.grid_view_rounded,
              label: 'Pijlers',
              color: const Color(0xFF00F5FF),
              onTap: () => onNavigate('pillars'),
            ),
            FeatureTile(
              icon: Icons.favorite_border,
              label: 'Check-in',
              color: const Color(0xFFFF4B91),
              onTap: () => onNavigate('checkin'),
            ),
            FeatureTile(
              icon: Icons.edit_note_outlined,
              label: 'Notities',
              color: const Color(0xFF9B5CFF),
              onTap: () => onNavigate('notes'),
            ),
            FeatureTile(
              icon: Icons.flag_outlined,
              label: 'Challenges',
              color: const Color(0xFFFFD166),
              onTap: () => onNavigate('challenges'),
            ),
            FeatureTile(
              icon: Icons.format_quote,
              label: 'Quotes',
              color: const Color(0xFF6EEB83),
              onTap: () => onNavigate('quotes'),
            ),
            FeatureTile(
              icon: Icons.help_outline,
              label: 'Hulp',
              color: const Color(0xFF00C2FF),
              onTap: () => onNavigate('help'),
            ),
          ],
        ),
      ],
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const FeatureTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0C1120),
              Color(0xFF090C18),
            ],
          ),
          border: Border.all(
            color: color.withOpacity(0.7),
            width: 1.1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 26),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Open ${label.toLowerCase()}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
