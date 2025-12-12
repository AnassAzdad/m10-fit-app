import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/language_toggle.dart';
import '../../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController(); // niet echt gebruikt

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    return Scaffold(
      appBar: AppBar(
        title: Text(L.t('app_title', lang)),
        actions: [
          LanguageToggle(
            onChanged: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              L.t('welcome_title', lang),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(L.t('welcome_subtitle', lang)),
            const SizedBox(height: 24),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: L.t('email_label', lang),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: L.t('password_label', lang),
              ),
              obscureText: true,
            ),
            const Spacer(),
            PrimaryButton(
              label: L.t('login_button', lang),
              onPressed: () {
                AppState.loginUser(emailController.text);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
