import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final List<_Challenge> _challenges = [
    _Challenge(
      title: '10 minuten ademhaling',
      description: 'Neem 10 minuten om rustig te ademen en je hoofd leeg te maken.',
      gradient: const [Color(0xFF10B981), Color(0xFF22C55E)],
    ),
    _Challenge(
      title: '30 minuten wandelen',
      description: 'Ga een half uur wandelen zonder telefoon, alleen jij en de omgeving.',
      gradient: const [Color(0xFF0EA5E9), Color(0xFF6366F1)],
    ),
    _Challenge(
      title: '2 liter water',
      description: 'Drink vandaag in totaal ongeveer 2 liter water.',
      gradient: const [Color(0xFFF59E0B), Color(0xFFF97316)],
    ),
    _Challenge(
      title: 'Compliment geven',
      description: 'Geef iemand vandaag een oprecht compliment.',
      gradient: const [Color(0xFFEC4899), Color(0xFFF43F5E)],
    ),
    _Challenge(
      title: '15 minuten offline',
      description: 'Leg je telefoon weg en doe iets wat jij leuk vindt.',
      gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050816),
        elevation: 0,
        title: const Text(
          'Challenges',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kies je challenge',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Vink 1 of meer challenges aan om jezelf vandaag uit te dagen.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 20),

                // Lijst met neon challenge cards
                for (final challenge in _challenges)
                  _ChallengeCard(
                    challenge: challenge,
                    onChanged: (value) {
                      setState(() {
                        challenge.completed = value;
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Challenge {
  final String title;
  final String description;
  final List<Color> gradient;
  bool completed;

  _Challenge({
    required this.title,
    required this.description,
    required this.gradient,
    this.completed = false,
  });
}

class _ChallengeCard extends StatefulWidget {
  final _Challenge challenge;
  final ValueChanged<bool> onChanged;

  const _ChallengeCard({
    super.key,
    required this.challenge,
    required this.onChanged,
  });

  @override
  State<_ChallengeCard> createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<_ChallengeCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.challenge;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => widget.onChanged(!c.completed),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: c.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: c.gradient.last.withOpacity(0.45),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(1.8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.35),
            ),
            child: Row(
              children: [
                // Checkbox in neon stijl
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    value: c.completed,
                    onChanged: (v) => widget.onChanged(v ?? false),
                    activeColor: Colors.white,
                    checkColor: Colors.black,
                    side: const BorderSide(color: Colors.white70, width: 1.5),
                  ),
                ),
                const SizedBox(width: 10),

                // Titel + beschrijving
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          decoration: c.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
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
