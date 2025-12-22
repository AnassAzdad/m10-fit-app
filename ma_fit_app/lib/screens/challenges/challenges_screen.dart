import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final items = <_Challenge>[
    _Challenge(
      titleNl: 'Schermpauze',
      titleEn: 'Screen break',
      descriptionNl: 'Elke dag minder schermtijd.',
      descriptionEn: 'Reduce screen time every day.',
      daysTotal: 7,
    ),
    _Challenge(
      titleNl: 'Slaapritme',
      titleEn: 'Sleep routine',
      descriptionNl: 'Ga elke dag op dezelfde tijd slapen.',
      descriptionEn: 'Go to bed at the same time every day.',
      daysTotal: 7,
    ),
    _Challenge(
      titleNl: 'Ademhaling',
      titleEn: 'Breathing',
      descriptionNl: 'Dagelijks 5 minuten rustig ademen.',
      descriptionEn: '5 minutes of calm breathing daily.',
      daysTotal: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(L.t('challenges_title', lang)),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
            children: [
              _HeaderCard(
                title: L.t('challenges_title', lang),
                subtitle: L.t('challenges_subtitle', lang),
              ),
              const SizedBox(height: 12),
              ...items.map(
                (c) => _ChallengeCard(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HeaderCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F1535),
            Color(0xFF080A1A),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF00F5FF).withOpacity(0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
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
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final _Challenge item;
  final AppLanguage lang;
  final VoidCallback onToggleDay;

  const _ChallengeCard({
    required this.item,
    required this.lang,
    required this.onToggleDay,
  });

  @override
  Widget build(BuildContext context) {
    final title = lang == AppLanguage.en ? item.titleEn : item.titleNl;
    final description =
        lang == AppLanguage.en ? item.descriptionEn : item.descriptionNl;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0C1120),
            Color(0xFF090C18),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF00F5FF).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${item.daysDone}/${item.daysTotal} ${L.t('days', lang)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: onToggleDay,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F5FF),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  L.t('btn_start', lang),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Challenge {
  final String titleNl;
  final String titleEn;
  final String descriptionNl;
  final String descriptionEn;
  final int daysTotal;
  int daysDone;

  _Challenge({
    required this.titleNl,
    required this.titleEn,
    required this.descriptionNl,
    required this.descriptionEn,
    required this.daysTotal,
    this.daysDone = 0,
  });
}
