import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/localization.dart';

class LanguageToggle extends StatelessWidget {
  final VoidCallback onChanged;

  const LanguageToggle({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isEn = AppState.language == AppLanguage.en;

    return IconButton(
      onPressed: () {
        AppState.language = isEn ? AppLanguage.nl : AppLanguage.en;
        onChanged();
      },
      icon: Text(
        isEn ? 'EN' : 'NL',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}
