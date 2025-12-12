import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../models/quote.dart';
import '../../widgets/primary_card.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;
    final List<AppQuote> quotes = AppState.quotes;

    return Scaffold(
      appBar: AppBar(
        title: Text(L.t('quotes_title', lang)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          final q = quotes[index];
          return PrimaryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"${q.text}"',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  q.author,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
