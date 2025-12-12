import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/language_toggle.dart';
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
    final user = AppState.currentUser;

    final pages = [
      _OverviewTab(onNavigate: _navigateTo),
      const PillarsScreen(),
      const CheckInScreen(),
      const NotesScreen(),
      const HelpScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(L.t('app_title', lang)),
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
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
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
    if (target == 'challenges') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ChallengesScreen()),
      );
    } else if (target == 'quotes') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const QuotesScreen()),
      );
    }
  }
}

class _OverviewTab extends StatelessWidget {
  final void Function(String target) onNavigate;

  const _OverviewTab({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser;
    final lang = AppState.language;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Hi ${user?.name ?? ''} 👋',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (user != null)
          Text('${user.opleiding} - ${user.klas}'),
        const SizedBox(height: 16),
        Text(L.t('welcome_subtitle', lang)),
        const SizedBox(height: 24),
        const Text(
          'Snel naar:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            ActionChip(
              label: const Text('Challenges'),
              onPressed: () => onNavigate('challenges'),
            ),
            ActionChip(
              label: const Text('Quotes'),
              onPressed: () => onNavigate('quotes'),
            ),
          ],
        ),
      ],
    );
  }
}
