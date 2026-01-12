enum QuoteCategory {
  study,
  mindset,
  confidence,
}

class AppQuote {
  final String id;
  final String text;
  final String author;
  final QuoteCategory category;

  AppQuote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
  });

  /* ======================
     SUPABASE → APP
  ====================== */

  factory AppQuote.fromMap(Map<String, dynamic> map) {
    return AppQuote(
      id: map['id'].toString(),
      text: map['text'] ?? '',
      author: map['author'] ?? 'MA Fit',
      category: _categoryFromString(map['category']),
    );
  }

  static QuoteCategory _categoryFromString(dynamic value) {
    switch (value) {
      case 'study':
        return QuoteCategory.study;
      case 'mind':
      case 'mindset':
        return QuoteCategory.mindset;
      case 'confidence':
        return QuoteCategory.confidence;
      default:
        return QuoteCategory.mindset;
    }
  }

  /* ======================
     DEMO DATA (LOCAL)
  ====================== */

  static List<AppQuote> demoQuotes = [
    // 📘 STUDY
    AppQuote(
      id: 's1',
      text: 'Kleine stappen zijn ook vooruitgang.',
      author: 'MA Fit',
      category: QuoteCategory.study,
    ),
    AppQuote(
      id: 's2',
      text: 'Je hoeft niet perfect te zijn om te leren.',
      author: 'MA Fit',
      category: QuoteCategory.study,
    ),

    // 🧠 MINDSET
    AppQuote(
      id: 'm1',
      text: 'Rust nemen is ook productief.',
      author: 'MA Fit',
      category: QuoteCategory.mindset,
    ),
    AppQuote(
      id: 'm2',
      text: 'Adem in. Adem uit. Je mag pauze nemen.',
      author: 'MA Fit',
      category: QuoteCategory.mindset,
    ),

    // 💪 CONFIDENCE
    AppQuote(
      id: 'c1',
      text: 'Vraag om hulp is geen zwakte.',
      author: 'MA Fit',
      category: QuoteCategory.confidence,
    ),
    AppQuote(
      id: 'c2',
      text: 'Je bent meer dan één slechte dag.',
      author: 'MA Fit',
      category: QuoteCategory.confidence,
    ),
  ];
}
