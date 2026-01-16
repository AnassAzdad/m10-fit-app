import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/phone_frame.dart';
import '../../widgets/primary_card.dart';
import 'challenges_screen.dart';

class ChallengeDetailScreen extends StatelessWidget {
  final ChallengeItem challenge;

  const ChallengeDetailScreen({
    super.key,
    required this.challenge,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    final title =
        lang == AppLanguage.en ? challenge.titleEn : challenge.titleNl;

    final description = lang == AppLanguage.en
        ? challenge.descriptionEn
        : challenge.descriptionNl;
    final steps = challenge.steps;

    final progress = challenge.daysTotal == 0
        ? 0.0
        : (challenge.daysDone / challenge.daysTotal).clamp(0.0, 1.0);

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
                backgroundColor: Colors.transparent,
                elevation: 0,

                // 🔥 DIT FIXT ALLES
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
                  /// BESCHRIJVING
                  PrimaryCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),

                        /// PROGRESS
                        Text(
                          '${challenge.daysDone}/${challenge.daysTotal} ${L.t('days', lang)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: const Color(0xFF141A2E),
                            valueColor: AlwaysStoppedAnimation(
                              challenge.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// STAPPEN
                  Text(
                    lang == AppLanguage.en ? 'Steps' : 'Stappen',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),

                  ...steps.map(
                    (s) => PrimaryCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(
                              color: challenge.accent,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              s,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ACTIE KNOP
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (challenge.daysDone < challenge.daysTotal) {
                          challenge.daysDone++;
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: challenge.accent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        challenge.daysDone >= challenge.daysTotal
                            ? (lang == AppLanguage.en
                                ? 'Completed'
                                : 'Voltooid')
                            : (lang == AppLanguage.en
                                ? 'Day done'
                                : 'Dag afronden'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
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
}
