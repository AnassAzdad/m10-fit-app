import 'package:flutter/material.dart';


import 'screens/pillars_screen.dart';
import 'screens/quotes_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/checkin_screen.dart';
import 'screens/steps_screen.dart';
import 'screens/help_screen.dart';

void main() {
  runApp(const MaFitApp());
}

class MaFitApp extends StatelessWidget {
  const MaFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MA Fit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFF050816),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

/// ----------------------------------------------------------
/// HOME – FITNESS LOOK
/// ----------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tiles = <_Tile>[
      _Tile(
        title: 'Pijlers',
        icon: Icons.self_improvement_rounded,
        gradient: const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        page: const PillarsScreen(),
      ),
      _Tile(
        title: 'Quotes',
        icon: Icons.format_quote_rounded,
        gradient: const [Color(0xFFEC4899), Color(0xFFF97316)],
        page: const QuotesScreen(),
      ),
      _Tile(
        title: 'Challenges',
        icon: Icons.flag_rounded,
        gradient: const [Color(0xFF10B981), Color(0xFF22C55E)],
        page: const ChallengesScreen(),
      ),
      _Tile(
        title: 'Check-in',
        icon: Icons.psychology_rounded,
        gradient: const [Color(0xFFFBBF24), Color(0xFFF97316)],
        page: const CheckinScreen(),
      ),
      _Tile(
        title: 'Stappen',
        icon: Icons.directions_walk_rounded,
        gradient: const [Color(0xFF0EA5E9), Color(0xFF6366F1)],
        page: const StepsScreen(),
      ),
      _Tile(
        title: 'Hulp',
        icon: Icons.health_and_safety_rounded,
        gradient: const [Color(0xFFEF4444), Color(0xFFF97316)],
        page: const HelpScreen(),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Donkerblauwe / paarsige gradient achtergrond – fitness/tech vibe
          gradient: LinearGradient(
            colors: [
              Color(0xFF050816),
              Color(0xFF020617),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TOP BAR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6366F1), Color(0xFF22C55E)],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'MA',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'MA Fit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // HERO HEADER
                    const Text(
                      'Hey student,',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Check in met je\nmentale & fysieke fitheid.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TODAY SUMMARY CARD
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1D2340),
                            Color(0xFF111827),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white12,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                              ),
                            ),
                            child: const Icon(
                              Icons.bolt_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Vandaag',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Begin met een korte check-in\nof kies een challenge.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Jouw dashboard',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // GRID MET FITNESS-TILES
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        childAspectRatio: 1.05,
                      ),
                      itemCount: tiles.length,
                      itemBuilder: (context, index) {
                        final t = tiles[index];
                        return HomeTile(
                          tile: t,
                          onTap: () => open(context, t.page),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tile data
class _Tile {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final Widget page;

  const _Tile({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.page,
  });
}

/// ----------------------------------------------------------
/// FITNESS TILE – MODERNE CARD
/// ----------------------------------------------------------
class HomeTile extends StatefulWidget {
  final _Tile tile;
  final VoidCallback onTap;

  const HomeTile({
    super.key,
    required this.tile,
    required this.onTap,
  });

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.97 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: widget.tile.gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.tile.gradient.last.withOpacity(0.45),
                blurRadius: 16,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(1.5),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  widget.tile.icon,
                  color: Colors.white,
                  size: 26,
                ),
                const Spacer(),
                Text(
                  widget.tile.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Open',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
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
