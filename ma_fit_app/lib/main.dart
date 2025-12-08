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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _Tile("Pijlers", Icons.star_rounded, const PillarsScreen()),
      _Tile("Quotes", Icons.format_quote_rounded, const QuotesScreen()),
      _Tile("Challenges", Icons.flag_rounded, const ChallengesScreen()),
      _Tile("Check-in", Icons.check_circle_rounded, const CheckinScreen()),
      _Tile("Stappen", Icons.directions_walk_rounded, const StepsScreen()),
      _Tile("Hulp", Icons.help_center_rounded, const HelpScreen()),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE5E8FF), Color(0xFFF4F7FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "HOME",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("LOGO"),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        childAspectRatio: 1, // ECHTE VIERKANTEN
                        children: tiles.map((t) {
                          return HomeTile(
                            title: t.title,
                            icon: t.icon,
                            onTap: (ctx) => open(context, t.page),
                          );
                        }).toList(),
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

class _Tile {
  final String title;
  final IconData icon;
  final Widget page;
  const _Tile(this.title, this.icon, this.page);
}

// ---------------- BOX TILE (ECHTE VIERKANT BOX) ----------------
class HomeTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function(BuildContext) onTap;

  const HomeTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: () => onTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),

          // ZICHTBARE RAND
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),

          // DUIDELIJKE SCHADUW
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 16,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4F46E5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: const Color(0xFF4F46E5)),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- Simple screens ----------------
class SimpleScreen extends StatelessWidget {
  final String title;
  final String description;

  const SimpleScreen({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            description,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


