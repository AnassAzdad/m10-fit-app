import 'package:flutter/material.dart';
import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/phone_frame.dart';
import 'challenge_detail_screen.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  String filter = 'all';

  final List<ChallengeItem> items = [
    ChallengeItem(
      id: 'focus',
      icon: Icons.center_focus_strong,
      accent: const Color(0xFF00F5FF),
      titleNl: 'Focus challenge',
      titleEn: 'Focus challenge',
      descriptionNl: 'Elke dag 25 minuten gefocust werken.',
      descriptionEn: 'Work focused for 25 minutes each day.',
      daysTotal: 7,
      steps: const [
        'Zet meldingen uit',
        'Werk 25 minuten',
        'Neem 5 minuten pauze',
      ],
      tags: {'focus'},
    ),
    ChallengeItem(
      id: 'sleep',
      icon: Icons.nights_stay,
      accent: const Color(0xFF9B5CFF),
      titleNl: 'Slaapritme',
      titleEn: 'Sleep routine',
      descriptionNl: 'Ga elke dag op dezelfde tijd slapen.',
      descriptionEn: 'Go to bed at the same time every day.',
      daysTotal: 7,
      steps: const [
        'Geen schermen 45 min vooraf',
        'Vaste bedtijd',
        'Koele kamer',
      ],
      tags: {'sleep'},
    ),
    ChallengeItem(
      id: 'stress',
      icon: Icons.air,
      accent: const Color(0xFF6EEB83),
      titleNl: 'Ademhaling',
      titleEn: 'Breathing',
      descriptionNl: 'Dagelijks rustig ademen.',
      descriptionEn: 'Daily calm breathing.',
      daysTotal: 5,
      steps: const [
        'Adem 4 sec in',
        'Adem 6 sec uit',
        '5 minuten',
      ],
      tags: {'stress'},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    final filtered = items.where((c) {
      if (filter == 'all') return true;
      return c.tags.contains(filter);
    }).toList();

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
          child: PhoneFrame(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,

          
                foregroundColor: Colors.white,

                title: const Text(
                  'Challenges',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _FilterRow(
                    current: filter,
                    onSelect: (v) => setState(() => filter = v),
                  ),
                  const SizedBox(height: 14),
                  ...filtered.map((c) => _ChallengeCard(
                        item: c,
                        lang: lang,
                        onOpen: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ChallengeDetailScreen(challenge: c),
                            ),
                          );
                          setState(() {});
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* =========================
   UI COMPONENTS
========================= */

class _FilterRow extends StatelessWidget {
  final String current;
  final void Function(String) onSelect;

  const _FilterRow({
    required this.current,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _chip('all', 'Alle'),
        _chip('focus', 'Focus'),
        _chip('sleep', 'Slaap'),
        _chip('stress', 'Stress'),
      ],
    );
  }

  Widget _chip(String v, String label) {
    final selected = v == current;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(v),
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: selected
                ? Colors.white.withOpacity(0.15)
                : const Color(0xFF141A2E),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final ChallengeItem item;
  final AppLanguage lang;
  final VoidCallback onOpen;

  const _ChallengeCard({
    required this.item,
    required this.lang,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final title = lang == AppLanguage.en ? item.titleEn : item.titleNl;
    final desc =
        lang == AppLanguage.en ? item.descriptionEn : item.descriptionNl;

    final progress = (item.daysDone / item.daysTotal).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: onOpen,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xFF141A2E),
          border: Border.all(color: item.accent.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(item.icon, color: item.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  '${item.daysDone}/${item.daysTotal}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(item.accent),
            ),
          ],
        ),
      ),
    );
  }
}



class ChallengeItem {
  final String id;
  final IconData icon;
  final Color accent;
  final String titleNl;
  final String titleEn;
  final String descriptionNl;
  final String descriptionEn;
  final int daysTotal;
  int daysDone;
  final List<String> steps;
  final Set<String> tags;

  ChallengeItem({
    required this.id,
    required this.icon,
    required this.accent,
    required this.titleNl,
    required this.titleEn,
    required this.descriptionNl,
    required this.descriptionEn,
    required this.daysTotal,
    required this.steps,
    required this.tags,
    this.daysDone = 0,
  });
}
