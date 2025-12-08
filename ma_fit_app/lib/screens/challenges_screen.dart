import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final List<_Challenge> _challenges = [
    _Challenge(
      title: '10 minuten ademhalingsoefening',
      description: 'Zoek een rustige plek en focus 10 minuten op je ademhaling.',
    ),
    _Challenge(
      title: '30 minuten wandelen zonder telefoon',
      description: 'Ga naar buiten zonder scherm en let op wat je ziet en hoort.',
    ),
    _Challenge(
      title: '2 liter water drinken',
      description: 'Drink verspreid over de dag genoeg water.',
    ),
    _Challenge(
      title: '1 persoon een compliment geven',
      description: 'Maak bewust iemands dag beter met een compliment.',
    ),
    _Challenge(
      title: '15 minuten iets doen wat jij leuk vindt',
      description: 'Gamen, muziek luisteren, tekenen… iets waar jij blij van wordt.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
        centerTitle: true,
      ),
      body: Container(
        // Zelfde soort achtergrond als andere screens
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
          // Mobile-first: scrollbaar + padding + max breedte
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kies één of meerdere challenges voor vandaag:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._challenges.map(
                    (challenge) => _ChallengeCard(
                      challenge: challenge,
                      onChanged: (value) {
                        setState(() {
                          challenge.completed = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
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
  bool completed;

  _Challenge({
    required this.title,
    required this.description,
    this.completed = false,
  });
}

/// Eén challenge-kaart in dezelfde stijl als je andere boxen,
/// met een kleine animatie bij aan/uit vinken.
class _ChallengeCard extends StatelessWidget {
  final _Challenge challenge;
  final ValueChanged<bool> onChanged;

  const _ChallengeCard({
    super.key,
    required this.challenge,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // AnimatedContainer zorgt voor smooth overgang bij completed true/false
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: challenge.completed
            ? const Color(0xFF4F46E5).withOpacity(0.06)
            : Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(challenge.completed ? 0.14 : 0.1),
            blurRadius: challenge.completed ? 18 : 14,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: CheckboxListTile(
        value: challenge.completed,
        onChanged: (v) => onChanged(v ?? false),
        
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: const Color(0xFF4F46E5),
        title: Text(
          challenge.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: challenge.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          challenge.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
