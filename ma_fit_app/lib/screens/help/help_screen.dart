import 'package:flutter/material.dart';

import '../../core/app_state.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppState.currentUser;
    final opleiding = user?.opleiding ?? '';
    final klas = user?.klas ?? '';

    final todayCount = (opleiding.isNotEmpty && klas.isNotEmpty)
        ? AppState.getTodayCountForClass(opleiding, klas)
        : 0;

    final avgMood = (opleiding.isNotEmpty && klas.isNotEmpty)
        ? AppState.getTodayAverageMoodForClass(opleiding, klas)
        : 0;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        /// HEADER
        const Text(
          'Hulp & ondersteuning',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Je staat er niet alleen voor. Hieronder vind je plekken waar je terecht kunt.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 14,
          ),
        ),

        const SizedBox(height: 18),

        /// BINNEN SCHOOL
        _InfoCard(
          icon: Icons.school,
          title: 'Binnen school',
          text:
              'Neem contact op met je mentor, SLB’er of vertrouwenspersoon. Zij zijn er om je te helpen.',
          accent: const Color(0xFF00F5FF),
        ),

        /// BUITEN SCHOOL
        _InfoCard(
          icon: Icons.support_agent,
          title: 'Buiten school',
          text:
              'Denk aan je huisarts, jongerenhulplijnen of organisaties zoals 113 Zelfmoordpreventie.',
          accent: const Color(0xFF6EEB83),
        ),

  
        _InfoCard(
          icon: Icons.warning_rounded,
          title: 'Spoed',
          text:
              'Is er direct gevaar? Bel 112 of ga naar de dichtstbijzijnde hulpdienst.',
          accent: const Color(0xFFFF4B91),
        ),

        const SizedBox(height: 18),

        
        _InfoCard(
          icon: Icons.groups,
          title: 'Klasoverzicht',
          text: (opleiding.isEmpty || klas.isEmpty)
              ? 'Log in met je opleiding en klas om dit overzicht te zien.'
              : 'Vandaag in $opleiding · $klas:\n'
                  '• $todayCount check-ins\n'
                  '• Gemiddelde mood: ${avgMood == 0 ? '-' : avgMood.toStringAsFixed(1)}',
          accent: const Color(0xFFFFD166),
        ),

        const SizedBox(height: 20),

   
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF141A2E),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
            ),
          ),
          child: Text(
            'MA Fit is een ondersteunende app en vervangt geen professionele hulp.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

/* =========================
   INFO CARD (HERBRUIKBAAR)
========================= */

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Color accent;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0C1120),
            Color(0xFF090C18),
          ],
        ),
        border: Border.all(
          color: accent.withOpacity(0.45),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.withOpacity(0.18),
              border: Border.all(color: accent.withOpacity(0.6)),
              boxShadow: [
                BoxShadow(
                  color: accent.withOpacity(0.5),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.82),
                    fontSize: 13,
                    height: 1.4,
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
