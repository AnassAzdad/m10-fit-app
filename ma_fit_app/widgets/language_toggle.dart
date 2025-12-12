import 'package:flutter/material.dart';

import '../core/app_state.dart';
import '../core/localization.dart';

class LanguageToggle extends StatefulWidget {
  final VoidCallback? onChanged;

  const LanguageToggle({super.key, this.onChanged});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  @override
  Widget build(BuildContext context) {
    final isNl = AppState.language == AppLanguage.nl;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              AppState.language = AppLanguage.nl;
            });
            widget.onChanged?.call();
          },
          child: Text(
            'NL',
            style: TextStyle(
              fontWeight: isNl ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              AppState.language = AppLanguage.en;
            });
            widget.onChanged?.call();
          },
          child: Text(
            'EN',
            style: TextStyle(
              fontWeight: !isNl ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
