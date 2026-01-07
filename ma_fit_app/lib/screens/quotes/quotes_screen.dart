import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../models/quote.dart';
import '../../widgets/primary_card.dart';
import '../../widgets/phone_frame.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  String filter = 'all';
  final Set<int> favorites = {};

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;
    final List<AppQuote> quotes = AppState.quotes;

    final filteredQuotes = quotes.where((q) {
      if (filter == 'all') return true;
      final txt = (q.text + ' ' + q.author).toLowerCase();
      if (filter == 'study') return txt.contains('study') || txt.contains('school') || txt.contains('leren');
      if (filter == 'mind') return txt.contains('mind') || txt.contains('stress') || txt.contains('rust') || txt.contains('calm');
      if (filter == 'confidence') return txt.contains('confidence') || txt.contains('trots') || txt.contains('self');
      return true;
    }).toList();

    final quoteOfDay = quotes.isNotEmpty ? quotes[DateTime.now().day % quotes.length] : null;

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
                title: Text(L.t('quotes_title', lang)),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: ListView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 18),
                children: [
                  _HeaderCard(
                    title: L.t('quotes_title', lang),
                    subtitle: lang == AppLanguage.en
                        ? 'Short boosts for focus and mindset.'
                        : 'Korte boosts voor focus en mindset.',
                    rightText: '${quotes.length}',
                    rightLabel: lang == AppLanguage.en ? 'quotes' : 'quotes',
                  ),
                  const SizedBox(height: 12),
                  _FilterRow(
                    current: filter,
                    onSelect: (v) => setState(() => filter = v),
                    labels: {
                      'all': lang == AppLanguage.en ? 'All' : 'Alle',
                      'study': lang == AppLanguage.en ? 'Study' : 'Studie',
                      'mind': lang == AppLanguage.en ? 'Mind' : 'Mindset',
                      'confidence': lang == AppLanguage.en ? 'Confidence' : 'Zelfvertrouwen',
                    },
                  ),
                  const SizedBox(height: 12),
                  if (quoteOfDay != null) ...[
                    _SectionTitle(
                      text: lang == AppLanguage.en ? 'Quote of the day' : 'Quote van de dag',
                    ),
                    const SizedBox(height: 8),
                    PrimaryCard(
                      child: _QuoteCardBody(
                        text: quoteOfDay.text,
                        author: quoteOfDay.author,
                        accent: const Color(0xFF6EEB83),
                        onCopy: () => _copy(context, '"${quoteOfDay.text}" — ${quoteOfDay.author}'),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                  _SectionTitle(
                    text: lang == AppLanguage.en ? 'All quotes' : 'Alle quotes',
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(filteredQuotes.length, (index) {
                    final q = filteredQuotes[index];
                    final originalIndex = quotes.indexOf(q);
                    final isFav = favorites.contains(originalIndex);

                    return PrimaryCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _QuoteCardBody(
                            text: q.text,
                            author: q.author,
                            accent: const Color(0xFF00F5FF),
                            onCopy: () => _copy(context, '"${q.text}" — ${q.author}'),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _MiniAction(
                                icon: Icons.copy,
                                label: lang == AppLanguage.en ? 'Copy' : 'Kopieer',
                                onTap: () => _copy(context, '"${q.text}" — ${q.author}'),
                              ),
                              const SizedBox(width: 10),
                              _MiniAction(
                                icon: isFav ? Icons.favorite : Icons.favorite_border,
                                label: lang == AppLanguage.en ? 'Save' : 'Opslaan',
                                onTap: () {
                                  setState(() {
                                    if (isFav) {
                                      favorites.remove(originalIndex);
                                    } else {
                                      favorites.add(originalIndex);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppState.language == AppLanguage.en ? 'Copied!' : 'Gekopieerd!'),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rightText;
  final String rightLabel;

  const _HeaderCard({
    required this.title,
    required this.subtitle,
    required this.rightText,
    required this.rightLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1535), Color(0xFF080A1A)],
        ),
        border: Border.all(color: const Color(0xFF00F5FF).withOpacity(0.25)),
      ),
      child: Row(
        children: [
          const _NeonIconCircle(icon: Icons.format_quote, glow: Color(0xFF6EEB83)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF141A2E),
              border: Border.all(color: Colors.white.withOpacity(0.10)),
            ),
            child: Column(
              children: [
                Text(rightText,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16)),
                Text(rightLabel, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String current;
  final void Function(String) onSelect;
  final Map<String, String> labels;

  const _FilterRow({
    required this.current,
    required this.onSelect,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: labels.entries.map((e) {
          final selected = e.key == current;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(e.value),
              selected: selected,
              onSelected: (_) => onSelect(e.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.92),
        fontSize: 13,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _QuoteCardBody extends StatelessWidget {
  final String text;
  final String author;
  final Color accent;
  final VoidCallback onCopy;

  const _QuoteCardBody({
    required this.text,
    required this.author,
    required this.accent,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NeonIconCircle(icon: Icons.bolt, glow: accent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"$text"',
                style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 6),
              Text(
                author,
                style: TextStyle(color: Colors.white.withOpacity(0.72), fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onCopy,
          icon: Icon(Icons.copy, color: Colors.white.withOpacity(0.65)),
        ),
      ],
    );
  }
}

class _MiniAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MiniAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF141A2E),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.white.withOpacity(0.85)),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeonIconCircle extends StatelessWidget {
  final IconData icon;
  final Color glow;
  const _NeonIconCircle({required this.icon, required this.glow});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: glow.withOpacity(0.14),
        border: Border.all(color: glow.withOpacity(0.45)),
        boxShadow: [
          BoxShadow(
            color: glow.withOpacity(0.16),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: glow, size: 22),
    );
  }
}
