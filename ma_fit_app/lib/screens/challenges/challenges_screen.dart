import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/phone_frame.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  String filter = 'all';

  final items = <ChallengeItem>[
    ChallengeItem(
      id: 'screen_break',
      accent: const Color(0xFF00F5FF),
      icon: Icons.phone_android,
      points: 120,
      tags: const {'focus', 'stress'},
      titleNl: 'Schermpauze',
      titleEn: 'Screen break',
      descriptionNl: 'Elke dag minder schermtijd.',
      descriptionEn: 'Reduce screen time every day.',
      daysTotal: 7,
      stepsNl: const [
        'Kies één vast moment op de dag (bijv. na school).',
        'Leg je telefoon uit het zicht (tas, lade).',
        'Doe iets anders: wandelen, rekken, muziek, lezen.',
        'Check na 1 uur pas weer je meldingen.',
      ],
      stepsEn: const [
        'Pick one fixed moment each day (e.g. after school).',
        'Put your phone out of sight (bag, drawer).',
        'Do something else: walk, stretch, music, read.',
        'Check notifications only after 1 hour.',
      ],
    ),
    ChallengeItem(
      id: 'sleep_routine',
      accent: const Color(0xFF9B5CFF),
      icon: Icons.nights_stay,
      points: 150,
      tags: const {'sleep'},
      titleNl: 'Slaapritme',
      titleEn: 'Sleep routine',
      descriptionNl: 'Ga elke dag op dezelfde tijd slapen.',
      descriptionEn: 'Go to bed at the same time every day.',
      daysTotal: 7,
      stepsNl: const [
        'Kies een bedtijd die haalbaar is voor school.',
        'Stop 45 minuten voor slapen met schermen.',
        'Maak je kamer donker en koel.',
        'Sta elke dag ongeveer dezelfde tijd op.',
      ],
      stepsEn: const [
        'Choose a bedtime that works for school.',
        'Stop screens 45 minutes before sleep.',
        'Make your room dark and cool.',
        'Wake up around the same time every day.',
      ],
    ),
    ChallengeItem(
      id: 'breathing',
      accent: const Color(0xFF6EEB83),
      icon: Icons.air,
      points: 100,
      tags: const {'stress'},
      titleNl: 'Ademhaling',
      titleEn: 'Breathing',
      descriptionNl: 'Dagelijks 5 minuten rustig ademen.',
      descriptionEn: '5 minutes of calm breathing daily.',
      daysTotal: 5,
      stepsNl: const [
        'Zet een timer op 5 minuten.',
        'Adem 4 seconden in en 6 seconden uit.',
        'Ontspan je schouders en kaak.',
        'Herhaal rustig tot de timer afgaat.',
      ],
      stepsEn: const [
        'Set a 5-minute timer.',
        'Inhale 4 seconds, exhale 6 seconds.',
        'Relax your shoulders and jaw.',
        'Repeat calmly until the timer ends.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    final totalDays = items.fold<int>(0, (sum, c) => sum + c.daysTotal);
    final doneDays = items.fold<int>(0, (sum, c) => sum + c.daysDone);
    final overallProgress = totalDays == 0 ? 0.0 : doneDays / totalDays;

    final filteredItems = items.where((c) {
      if (filter == 'all') return true;
      return c.tags.contains(filter);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                title: Text(L.t('challenges_title', lang)),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: ListView(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
                children: [
                  HeaderCard(
                    title: L.t('challenges_title', lang),
                    subtitle: L.t('challenges_subtitle', lang),
                    rightTop: '${items.length}',
                    rightBottom: lang == AppLanguage.en ? 'challenges' : 'challenges',
                    progressValue: overallProgress,
                    progressLabel: '$doneDays/$totalDays ${L.t('days', lang)}',
                  ),
                  const SizedBox(height: 12),
                  _FilterRow(
                    current: filter,
                    onSelect: (v) => setState(() => filter = v),
                    labels: {
                      'all': lang == AppLanguage.en ? 'All' : 'Alle',
                      'focus': lang == AppLanguage.en ? 'Focus' : 'Focus',
                      'sleep': lang == AppLanguage.en ? 'Sleep' : 'Slaap',
                      'stress': lang == AppLanguage.en ? 'Stress' : 'Stress',
                    },
                  ),
                  const SizedBox(height: 12),
                  ...filteredItems.map(
                    (c) => ChallengeCard(
                      item: c,
                      lang: lang,
                      onToggleDay: () {
                        setState(() {
                          if (c.daysDone < c.daysTotal) {
                            c.daysDone++;
                          } else {
                            c.daysDone = 0;
                          }
                        });
                      },
                      onOpenDetails: () => _openDetails(context, c, lang),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, ChallengeItem c, AppLanguage lang) {
    final title = lang == AppLanguage.en ? c.titleEn : c.titleNl;
    final description = lang == AppLanguage.en ? c.descriptionEn : c.descriptionNl;
    final steps = lang == AppLanguage.en ? c.stepsEn : c.stepsNl;

    final isDone = c.daysDone >= c.daysTotal;
    final isActive = c.daysDone > 0 && !isDone;

    final statusText = isDone
        ? (lang == AppLanguage.en ? 'Done' : 'Klaar')
        : isActive
            ? (lang == AppLanguage.en ? 'Active' : 'Bezig')
            : (lang == AppLanguage.en ? 'Start' : 'Start');

    final btnText = isDone
        ? (lang == AppLanguage.en ? 'Reset' : 'Reset')
        : isActive
            ? (lang == AppLanguage.en ? 'Add day' : 'Dag +1')
            : (lang == AppLanguage.en ? 'Start' : 'Start');

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0C1120),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Row(
                children: [
                  _NeonIconCircle(icon: c.icon, glow: c.accent),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  _Badge(
                    text: statusText,
                    border: c.accent.withOpacity(0.35),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.80),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _Badge(
                    text: '${c.daysTotal} ${L.t('days', lang)}',
                    border: Colors.white.withOpacity(0.12),
                  ),
                  _Badge(
                    text: '${c.points} ${lang == AppLanguage.en ? 'points' : 'punten'}',
                    border: Colors.white.withOpacity(0.12),
                  ),
                  _Badge(
                    text: '${c.daysDone}/${c.daysTotal}',
                    border: Colors.white.withOpacity(0.12),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                lang == AppLanguage.en ? 'How to do it' : 'Hoe doe je dit?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              ...steps.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '•  ',
                        style: TextStyle(
                          color: c.accent.withOpacity(0.95),
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          s,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.82),
                            fontSize: 13,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      if (c.daysDone < c.daysTotal) {
                        c.daysDone++;
                      } else {
                        c.daysDone = 0;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: c.accent.withOpacity(0.95),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    btnText,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rightTop;
  final String rightBottom;
  final double progressValue;
  final String progressLabel;

  const HeaderCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.rightTop,
    required this.rightBottom,
    required this.progressValue,
    required this.progressLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1535), Color(0xFF080A1A)],
        ),
        border: Border.all(color: const Color(0xFF00F5FF).withOpacity(0.35)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00F5FF).withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const _NeonIconCircle(icon: Icons.flag, glow: Color(0xFF00F5FF)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                _ProgressBar(value: progressValue),
                const SizedBox(height: 6),
                Text(
                  progressLabel,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF141A2E),
              border: Border.all(color: Colors.white.withOpacity(0.10)),
            ),
            child: Column(
              children: [
                Text(
                  rightTop,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                Text(
                  rightBottom,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String current;
  final void Function(String) onSelect;
  final Map<String, String> labels;

  const _FilterRow({
    required this.current,
    required this.onSelect,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: labels.entries.map((e) {
          final selected = e.key == current;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(e.value),
              selected: selected,
              onSelected: (_) => onSelect(e.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final ChallengeItem item;
  final AppLanguage lang;
  final VoidCallback onToggleDay;
  final VoidCallback onOpenDetails;

  const ChallengeCard({
    super.key,
    required this.item,
    required this.lang,
    required this.onToggleDay,
    required this.onOpenDetails,
  });

  @override
  Widget build(BuildContext context) {
    final title = lang == AppLanguage.en ? item.titleEn : item.titleNl;
    final description = lang == AppLanguage.en ? item.descriptionEn : item.descriptionNl;

    final isDone = item.daysDone >= item.daysTotal;
    final isActive = item.daysDone > 0 && !isDone;

    final statusText = isDone
        ? (lang == AppLanguage.en ? 'Done' : 'Klaar')
        : isActive
            ? (lang == AppLanguage.en ? 'Active' : 'Bezig')
            : (lang == AppLanguage.en ? 'Start' : 'Start');

    final btnText = isDone
        ? (lang == AppLanguage.en ? 'Reset' : 'Reset')
        : isActive
            ? (lang == AppLanguage.en ? 'Add day' : 'Dag +1')
            : (lang == AppLanguage.en ? 'Start' : 'Start');

    final progress = item.daysTotal == 0 ? 0.0 : (item.daysDone / item.daysTotal).clamp(0.0, 1.0);

    return InkWell(
      onTap: onOpenDetails,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF0C1120), Color(0xFF090C18)],
          ),
          border: Border.all(color: item.accent.withOpacity(0.30)),
          boxShadow: [
            BoxShadow(
              color: item.accent.withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _NeonIconCircle(icon: item.icon, glow: item.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                _Badge(
                  text: statusText,
                  border: item.accent.withOpacity(0.35),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Badge(
                  text: '${item.daysTotal} ${L.t('days', lang)}',
                  border: Colors.white.withOpacity(0.12),
                ),
                _Badge(
                  text: '${item.points} ${lang == AppLanguage.en ? 'points' : 'punten'}',
                  border: Colors.white.withOpacity(0.12),
                ),
                _Badge(
                  text: '${item.daysDone}/${item.daysTotal}',
                  border: Colors.white.withOpacity(0.12),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _ProgressBar(value: progress, glow: item.accent),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${item.daysDone}/${item.daysTotal} ${L.t('days', lang)}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onToggleDay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: item.accent.withOpacity(0.95),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  ),
                  child: Text(
                    btnText,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeItem {
  final String id;
  final Color accent;
  final IconData icon;
  final int points;
  final Set<String> tags;

  final String titleNl;
  final String titleEn;
  final String descriptionNl;
  final String descriptionEn;

  final int daysTotal;
  int daysDone;

  final List<String> stepsNl;
  final List<String> stepsEn;

  ChallengeItem({
    required this.id,
    required this.accent,
    required this.icon,
    required this.points,
    required this.tags,
    required this.titleNl,
    required this.titleEn,
    required this.descriptionNl,
    required this.descriptionEn,
    required this.daysTotal,
    required this.stepsNl,
    required this.stepsEn,
    this.daysDone = 0,
  });
}

class _Badge extends StatelessWidget {
  final String text;
  final Color border;

  const _Badge({required this.text, required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFF141A2E),
        border: Border.all(color: border),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.88),
          fontSize: 11,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final double value;
  final Color glow;

  const _ProgressBar({
    required this.value,
    this.glow = const Color(0xFF00F5FF),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withOpacity(0.08),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: value.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              color: glow.withOpacity(0.95),
              boxShadow: [
                BoxShadow(
                  color: glow.withOpacity(0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NeonIconCircle extends StatelessWidget {
  final IconData icon;
  final Color glow;
  const _NeonIconCircle({required this.icon, required this.glow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glow.withOpacity(0.14),
        border: Border.all(color: glow.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: glow.withOpacity(0.16),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: glow, size: 22),
    );
  }
}
