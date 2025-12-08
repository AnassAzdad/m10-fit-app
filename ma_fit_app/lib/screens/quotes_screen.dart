import 'dart:math';
import 'package:flutter/material.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final _random = Random();

  // Lijst met quotes + auteur
  final List<_Quote> _quotes = const [
    _Quote(
      text: 'Kleine stappen, elke dag, zorgen voor grote veranderingen.',
      author: 'MA Fit',
    ),
    _Quote(
      text: 'Je hoeft het niet perfect te doen, je hoeft het alleen te proberen.',
      author: 'Onbekend',
    ),
    _Quote(
      text: 'Adem in, adem uit. Je mag rustig aan doen.',
      author: 'Onbekend',
    ),
    _Quote(
      text: 'Fouten maken mag, zo leer je het meest.',
      author: 'Onbekend',
    ),
    _Quote(
      text: 'Je bent verder dan je gisteren was, dat telt.',
      author: 'MA Fit',
    ),
    _Quote(
      text: 'Zorg goed voor jezelf, je bent het waard.',
      author: 'Onbekend',
    ),
  ];

  int _currentIndex = 0;

  void _nextQuote() {
    if (_quotes.length == 1) return;

    int newIndex;
    do {
      newIndex = _random.nextInt(_quotes.length);
    } while (newIndex == _currentIndex);

    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuote = _quotes[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        centerTitle: true,
      ),
      body: Container(
        // Mobile-first achtergrond: zacht en rustig
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5E8FF),
              Color(0xFFF7F8FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          // SingleChildScrollView = veilig op kleinere schermen
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Max breedte zodat het op mobiel perfect is en op desktop niet te breed
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      // Fade + lichte slide van onder naar boven
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    // key zorgt dat AnimatedSwitcher snapt dat het een nieuwe quote is
                    child: Container(
                      key: ValueKey(_currentIndex),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 16,
                            spreadRadius: 1,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            size: 32,
                            color: const Color(0xFF4F46E5).withOpacity(0.7),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Quote van de dag',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            '"${currentQuote.text}"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '- ${currentQuote.author}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Quote ${_currentIndex + 1} van ${_quotes.length}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Knop ook mobile-first: max breedte, maar vult mooi op mobiel
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _nextQuote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'Nieuwe quote',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Klein model voor een quote
class _Quote {
  final String text;
  final String author;

  const _Quote({
    required this.text,
    required this.author,
  });
}
