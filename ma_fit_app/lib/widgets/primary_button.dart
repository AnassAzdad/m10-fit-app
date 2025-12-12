import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF00F5FF),
              Color(0xFF9B5CFF),
            ],
          ),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00F5FF).withOpacity(0.4),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
