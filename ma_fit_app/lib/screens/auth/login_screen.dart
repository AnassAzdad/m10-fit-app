import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/auth_service.dart';
bool rememberMe = true;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  final opleidingController = TextEditingController();
  final klasController = TextEditingController();

  bool isRegister = false;
  bool loading = false;
  String? errorText;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    opleidingController.dispose();
    klasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF050816),
              Color(0xFF09041A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF0F1535),
                      Color(0xFF080A1A),
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFF00F5FF).withOpacity(0.42),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00F5FF).withOpacity(0.24),
                      blurRadius: 30,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'MA Fit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isRegister ? 'Maak een account aan' : 'Welkom terug',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.78),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),

                    if (isRegister) ...[
                      TextField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _input('Naam'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: opleidingController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _input('Opleiding'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: klasController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _input('Klas'),
                      ),
                      const SizedBox(height: 12),
                    ],

                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _input('E-mail'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _input('Wachtwoord'),
                      obscureText: true,
                    ),

                    if (errorText != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        errorText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFF4B91),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],

                    const SizedBox(height: 18),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00F5FF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: loading ? null : _submit,
                      child: loading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              isRegister ? 'Account aanmaken' : 'Inloggen',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            errorText = null;
                            isRegister = !isRegister;
                          });
                        },
                        child: Text(
                          isRegister
                              ? 'Heb je al een account? Inloggen'
                              : 'Account aanmaken',
                          style: const TextStyle(
                            color: Color(0xFF00F5FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    if (!isRegister) ...[
                      const SizedBox(height: 2),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Wachtwoord vergeten'),
                                content: const Text(
                                  'Dit is een prototype. Neem contact op met je mentor of de administratie om je account te herstellen.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Oké'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'Wachtwoord vergeten?',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    setState(() {
      loading = true;
      errorText = null;
    });

    String? err;

    if (isRegister) {
      err = await AuthService.register(
        email: email,
        password: pass,
        name: nameController.text.trim(),
        opleiding: opleidingController.text.trim(),
        klas: klasController.text.trim(),
      );
    } else {
      err = await AuthService.login(email: email, password: pass);
    }

    if (!mounted) return;

    if (err != null) {
      setState(() {
        loading = false;
        errorText = _mapError(err!);
      });
      return;
    }

    final user = await AuthService.getSessionUser();
    AppState.currentUser = user;

    if (!mounted) return;

    setState(() => loading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  String _mapError(String key) {
    if (key == 'invalid_email') return 'Ongeldige e-mail.';
    if (key == 'weak_password') return 'Wachtwoord is te kort (minimaal 4).';
    if (key == 'email_exists') return 'Deze e-mail bestaat al.';
    if (key == 'not_found') return 'Account niet gevonden. Maak eerst een account.';
    if (key == 'wrong_password') return 'Wachtwoord klopt niet.';
    return 'Er ging iets mis.';
  }

  InputDecoration _input(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
      filled: true,
      fillColor: const Color(0xFF141A2E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
