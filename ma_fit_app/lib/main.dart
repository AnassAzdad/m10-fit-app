import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MAFitApp());
}

class MAFitApp extends StatelessWidget {
  const MAFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MA Fit',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
      },

      /// 👇 HIER MAKEN WE HEM “PHONE-SIZE” OOK OP PC
      builder: (context, child) {
        // child = de hele app (alle schermen)
        return Container(
          color: const Color(0xFFe5e9f2), // lichte achtergrond buiten de “phone”
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 430, // max breedte van je “telefoon”
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32), // optioneel: afgeronde hoeken
              child: child,
            ),
          ),
        );
      },
    );
  }
}
