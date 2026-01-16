import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final Widget framedChild;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    required this.framedChild,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // 📱 Telefoon → fullscreen
    if (width < 600) {
      return child;
    }

    // 💻 Desktop / laptop → phone frame
    return Center(
      child: framedChild,
    );
  }
}
