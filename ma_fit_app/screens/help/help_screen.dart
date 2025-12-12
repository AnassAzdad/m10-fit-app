import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/primary_card.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          L.t('help_title', lang),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const PrimaryCard(
          child: Text(
            'Heb je het moeilijk? Praat met iemand van school of neem contact op met je huisarts. '
            'In noodsituaties bel altijd 112.',
          ),
        ),
        const PrimaryCard(
          child: Text(
            'Landelijke hulplijnen (NL):\n\n'
            '- 113 Zelfmoordpreventie: 0800-0113\n'
            '- De Luisterlijn: 088 0767 000\n',
          ),
        ),
      ],
    );
  }
}
