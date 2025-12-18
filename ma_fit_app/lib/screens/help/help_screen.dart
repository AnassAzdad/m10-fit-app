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
        _card(
          title: 'Hulp nodig?',
          text: 'Je staat er niet alleen voor. Er zijn mensen en plekken binnen en buiten school die je kunnen helpen.',
          accent: const Color(0xFF00C2FF),
        ),
        _card(
          title: 'Binnen school',
          text: 'Neem contact op met je mentor, SLB’er of vertrouwenspersoon.',
          accent: const Color(0xFF00F5FF),
        ),
        _card(
          title: 'Buiten school',
          text: 'Denk aan de huisarts, jongerenhulplijn of een organisatie zoals 113.',
          accent: const Color(0xFF6EEB83),
        ),
        _card(
          title: 'Spoed',
          text: 'Bel 112 als er direct gevaar is.',
          accent: const Color(0xFFFF4B91),
        ),
        const SizedBox(height: 10),
        _card(
          title: 'Klasoverzicht (prototype)',
          text: (opleiding.isEmpty || klas.isEmpty)
              ? 'Log in met je opleiding en klas om dit overzicht te zien.'
              : 'Vandaag in $opleiding · $klas:\n$todayCount check-ins · Gemiddelde mood: ${avgMood == 0 ? '-' : avgMood.toStringAsFixed(1)}',
          accent: const Color(0xFFFFD166),
        ),
      ],
    );
  }

  Widget _card({
    required String title,
    required String text,
    required Color accent,
  }) {
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
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.16),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.82),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
