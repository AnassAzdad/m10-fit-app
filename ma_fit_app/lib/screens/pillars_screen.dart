import 'package:flutter/material.dart';

class PillarsScreen extends StatelessWidget {
  const PillarsScreen({super.key});

  // Lijst met de 8 pijlers
  List<_Pillar> get _pillars => const [
        _Pillar(
          title: 'Slaap',
          description: 'Goed en voldoende slapen voor herstel en energie.',
          icon: Icons.nightlight_round,
        ),
        _Pillar(
          title: 'Beweging',
          description: 'Regelmatig bewegen voor een fit lichaam en hoofd.',
          icon: Icons.directions_run_rounded,
        ),
        _Pillar(
          title: 'Voeding',
          description: 'Gezonde voeding voor focus en een stabiel energieniveau.',
          icon: Icons.restaurant_rounded,
        ),
        _Pillar(
          title: 'Ontspanning',
          description: 'Momenten nemen om te relaxen en stress los te laten.',
          icon: Icons.self_improvement_rounded,
        ),
        _Pillar(
          title: 'Sociaal',
          description: 'Contact met vrienden, familie en klasgenoten.',
          icon: Icons.people_rounded,
        ),
        _Pillar(
          title: 'Mindset',
          description: 'Positief denken en omgaan met tegenslagen.',
          icon: Icons.psychology_rounded,
        ),
        _Pillar(
          title: 'Structuur',
          description:
              'Planning, ritme en duidelijke afspraken met jezelf.',
          icon: Icons.event_note_rounded,
        ),
        _Pillar(
          title: 'Hulp vragen',
          description: 'Op tijd hulp vragen als het even niet gaat.',
          icon: Icons.support_agent_rounded,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pijlers"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFFE5E8FF),
      ),

      // ACHTERGROND STYLING
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5E8FF),
              Color(0xFFF4F7FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: _pillars.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),

          itemBuilder: (context, index) {
            final pillar = _pillars[index];

            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),

                // ZICHTBARE RAND
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),

                // SCHADUW (matcht Home tiles)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Row(
                children: [
                  
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4F46E5).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      pillar.icon,
                      size: 28,
                      color: const Color(0xFF4F46E5),
                    ),
                  ),

                  const SizedBox(width: 18),

                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pillar.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          pillar.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Pillar {
  final String title;
  final String description;
  final IconData icon;

  const _Pillar({
    required this.title,
    required this.description,
    required this.icon,
  });
}