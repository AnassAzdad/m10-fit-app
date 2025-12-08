import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigate(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'LOGO',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  children: [
                    _HomeTile(
                      label: 'Pijlers',
                      onTap: (context) => navigate(context, '/pillars'),
                    ),
                    _HomeTile(
                      label: 'Quotes',
                      onTap: (context) => navigate(context, '/quotes'),
                    ),
                    _HomeTile(
                      label: 'Challenges',
                      onTap: (context) => navigate(context, '/challenges'),
                    ),
                    _HomeTile(
                      label: 'Check-in',
                      onTap: (context) => navigate(context, '/checkin'),
                    ),
                    _HomeTile(
                      label: 'Stappen',
                      onTap: (context) => navigate(context, '/steps'),
                    ),
                    _HomeTile(
                      label: 'Hulp',
                      onTap: (context) => navigate(context, '/help'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final String label;
  final void Function(BuildContext) onTap;

  const _HomeTile({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => onTap(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade300),
          color: const Color(0xFFF8F8F8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
