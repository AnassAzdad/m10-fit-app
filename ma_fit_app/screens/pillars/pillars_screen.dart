import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../models/pillar.dart';
import '../../widgets/primary_card.dart';
import 'pillar_detail_screen.dart';

class PillarsScreen extends StatelessWidget {
  const PillarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pillar> pillars = AppState.pillars;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pillars.length,
      itemBuilder: (context, index) {
        final p = pillars[index];
        return PrimaryCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PillarDetailScreen(pillar: p),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(p.shortDescription),
            ],
          ),
        );
      },
    );
  }
}
