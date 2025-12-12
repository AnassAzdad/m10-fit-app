class AppQuote {
  final String id;
  final String text;
  final String author;

  AppQuote({
    required this.id,
    required this.text,
    required this.author,
  });

  static List<AppQuote> demoQuotes = [
    AppQuote(
      id: '1',
      text: 'Je hoeft het niet alleen te doen.',
      author: 'MA Fit',
    ),
    AppQuote(
      id: '2',
      text: 'Kleine stappen zijn ook vooruitgang.',
      author: 'MA Fit',
    ),
    AppQuote(
      id: '3',
      text: 'Vraag om hulp is geen zwakte.',
      author: 'MA Fit',
    ),
  ];
}
