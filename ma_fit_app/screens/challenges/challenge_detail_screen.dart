import 'package:flutter/material.dart';

import '../../models/challenge.dart';
import '../../widgets/primary_card.dart';

class ChallengeDetailScreen extends StatelessWidget {
  final Challenge challenge;

  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(challenge.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            challenge.description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          const Text(
            'Doel',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(challenge.goal),
          const SizedBox(height: 16),
          const Text(
            'Stappen',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...challenge.steps.map(
            (s) => PrimaryCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  const SizedBox(width: 4),
                  Expanded(child: Text(s)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Duur: ${challenge.durationDays} dagen'),
        ],
      ),
    );
  }
}
