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

    // ✅ ECHT filteren
    final List<AppQuote> filteredQuotes = quotes.where((q) {
      if (filter == 'all') return true;
      return q.category == filter;
    }).toList();

    final quoteOfDay = filteredQuotes.isNotEmpty
        ? filteredQuotes[DateTime.now().day % filteredQuotes.length]
        : null;

    // 🔤 Titel
    String pageTitle = 'Quotes';
    if (filter == 'study') pageTitle = 'Studie quotes';
    if (filter == 'mind') pageTitle = 'Mindset quotes';
    if (filter == 'confidence') pageTitle = 'Zelfvertrouwen quotes';

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
                title: Text(
                  pageTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              body: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                children: [
                  // 🌟 Quote van de dag
                  if (quoteOfDay != null) ...[
                    Text(
                      lang == AppLanguage.en
                          ? 'Quote of the day'
                          : 'Quote van de dag',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    PrimaryCard(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF6EEB83).withOpacity(0.6),
                            width: 1.2,
                          ),
                        ),
                        child: QuoteCardBody(
                          text: quoteOfDay.text,
                          author: quoteOfDay.author,
                          accent: const Color(0xFF6EEB83),
                          onCopy: () => _copy(
                            context,
                            '"${quoteOfDay.text}" — ${quoteOfDay.author}',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],

                  // 🎯 Filters
                  FilterRow(
                    current: filter,
                    onSelect: (v) => setState(() => filter = v),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    lang == AppLanguage.en ? 'All quotes' : 'Alle quotes',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (filteredQuotes.isEmpty)
                    Text(
                      lang == AppLanguage.en
                          ? 'No quotes in this category.'
                          : 'Geen quotes in deze categorie.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),

                  ...filteredQuotes.map((q) {
                    final originalIndex = quotes.indexOf(q);
                    final isFav = favorites.contains(originalIndex);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PrimaryCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuoteCardBody(
                              text: q.text,
                              author: q.author,
                              accent: const Color(0xFF00F5FF),
                              onCopy: () => _copy(
                                context,
                                '"${q.text}" — ${q.author}',
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                MiniAction(
                                  icon: Icons.copy,
                                  label: lang == AppLanguage.en
                                      ? 'Copy'
                                      : 'Kopieer',
                                  onTap: () => _copy(
                                    context,
                                    '"${q.text}" — ${q.author}',
                                  ),
                                ),
                                const SizedBox(width: 10),
                                MiniAction(
                                  icon: isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  label: lang == AppLanguage.en
                                      ? 'Save'
                                      : 'Opslaan',
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
                      ),
                    );
                  }).toList(),
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
        content: Text(
          AppState.language == AppLanguage.en ? 'Copied!' : 'Gekopieerd!',
        ),
        duration: const Duration(milliseconds: 900),
      ),
    );
  }
}

/* =======================
   FILTER ROW
======================= */

class FilterRow extends StatelessWidget {
  final String current;
  final void Function(String) onSelect;

  const FilterRow({
    super.key,
    required this.current,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChipItem(
          label: 'Alle',
          selected: current == 'all',
          color: Colors.white,
          onTap: () => onSelect('all'),
        ),
        const SizedBox(width: 8),
        FilterChipItem(
          label: 'Studie',
          selected: current == 'study',
          color: const Color(0xFF00F5FF),
          onTap: () => onSelect('study'),
        ),
        const SizedBox(width: 8),
        FilterChipItem(
          label: 'Mindset',
          selected: current == 'mind',
          color: const Color(0xFF9B5CFF),
          onTap: () => onSelect('mind'),
        ),
        const SizedBox(width: 8),
        FilterChipItem(
          label: 'Zelfvertrouwen',
          selected: current == 'confidence',
          color: const Color(0xFFFF4B91),
          onTap: () => onSelect('confidence'),
        ),
      ],
    );
  }
}

class FilterChipItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const FilterChipItem({
    super.key,
    required this.label,
    required this.selected,
    required this.color,
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
            color:
                selected ? color.withOpacity(0.22) : const Color(0xFF141A2E),
            border: Border.all(
              color: selected ? color : Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected
                    ? color
                    : Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* =======================
   QUOTE CARD
======================= */

class QuoteCardBody extends StatelessWidget {
  final String text;
  final String author;
  final Color accent;
  final VoidCallback onCopy;

  const QuoteCardBody({
    super.key,
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
        NeonIconCircle(icon: Icons.bolt, glow: accent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"$text"',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                author,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.72),
                  fontStyle: FontStyle.italic,
                ),
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

class MiniAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const MiniAction({
    super.key,
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
              Icon(icon,
                  size: 18,
                  color: Colors.white.withOpacity(0.85)),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NeonIconCircle extends StatelessWidget {
  final IconData icon;
  final Color glow;

  const NeonIconCircle({
    super.key,
    required this.icon,
    required this.glow,
  });

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
