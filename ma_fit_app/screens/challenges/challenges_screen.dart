import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../models/challenge.dart';
import '../../widgets/primary_card.dart';
import 'challenge_detail_screen.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;
    final List<Challenge> challenges = AppState.challenges;

    return Scaffold(
      appBar: AppBar(
        title: Text(L.t('challenges_title', lang)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          final c = challenges[index];
          return PrimaryCard(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChallengeDetailScreen(challenge: c),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(c.description),
              ],
            ),
          );
        },
      ),
    );
  }
}
