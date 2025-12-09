import 'package:flutter/material.dart';

class PillarsScreen extends StatelessWidget {
  const PillarsScreen({super.key});

  List<_Pillar> get _pillars => const [
        _Pillar(
          title: "Slaap",
          description: "Rust is essentieel voor herstel en balans.",
          icon: Icons.nightlight_round,
          gradient: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        _Pillar(
          title: "Beweging",
          description: "Je lichaam in beweging houden geeft je energie.",
          icon: Icons.fitness_center_rounded,
          gradient: [Color(0xFF10B981), Color(0xFF22C55E)],
        ),
        _Pillar(
          title: "Voeding",
          description: "Goede voeding ondersteunt je focus en gezondheid.",
          icon: Icons.restaurant_rounded,
          gradient: [Color(0xFFF59E0B), Color(0xFFF97316)],
        ),
        _Pillar(
          title: "Ontspanning",
          description: "Tijd nemen om te ademen en tot rust te komen.",
          icon: Icons.spa_rounded,
          gradient: [Color(0xFFEC4899), Color(0xFFF43F5E)],
        ),
        _Pillar(
          title: "Sociaal",
          description: "Verbonden blijven met mensen om je heen.",
          icon: Icons.people_alt_rounded,
          gradient: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
        ),
        _Pillar(
          title: "Mindset",
          description: "Sterke gedachten, sterke keuzes.",
          icon: Icons.psychology_rounded,
          gradient: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
        ),
        _Pillar(
          title: "Structuur",
          description: "Een ritme geeft rust en overzicht.",
          icon: Icons.calendar_month_rounded,
          gradient: [Color(0xFF14B8A6), Color(0xFF0D9488)],
        ),
        _Pillar(
          title: "Hulp vragen",
          description: "Niemand staat er alleen voor.",
          icon: Icons.support_agent_rounded,
          gradient: [Color(0xFFEF4444), Color(0xFFF97316)],
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
          'Pijlers',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _pillars.length,
        itemBuilder: (context, index) {
          return _PillarCard(pillar: _pillars[index]);
        },
      ),
    );
  }
}

class _Pillar {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  const _Pillar({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}

class _PillarCard extends StatefulWidget {
  final _Pillar pillar;

  const _PillarCard({super.key, required this.pillar});

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        child: Container(
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: widget.pillar.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.pillar.gradient.last.withOpacity(0.45),
                offset: const Offset(0, 10),
                blurRadius: 20,
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withOpacity(0.25),
            ),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.pillar.icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pillar.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.pillar.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}