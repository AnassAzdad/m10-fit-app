import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const PrimaryCard({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0C1120),
            Color(0xFF090C18),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFF00F5FF).withOpacity(0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00F5FF).withOpacity(0.20),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return card;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: card,
    );
  }
}
