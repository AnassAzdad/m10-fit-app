import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  final klasController = TextEditingController();

  bool isRegister = false;
  bool loading = false;
  String? errorText;

  String? selectedOpleiding;

  bool rememberMe = true;

  final List<String> opleidingenMA = const [
    'Immersive designer',
    'Podium- en evenemententechnicus',
    'Medewerker creatieve productie',
    'Allround mediamaker (dtp-er)',
    'Signspecialist',
    'Mediaredactiemedewerker',
    'Media- en eventproducer & Music industry professional',
    'Ruimtelijk vormgever',
    'Mediavormgever',
    'E-commerce designer',
    'Audiovisueel',
    'Photographic designer',
    'Game artist',
    'Creative software developer',
    'Tech software developer',
    'Filmacteur',
  ];

  @override
  void initState() {
    super.initState();
    _loadRemember();
  }

  Future<void> _loadRemember() async {
    final r = await AuthService.getRememberMe();
    final email = await AuthService.getRememberedEmail();

    if (!mounted) return;

    setState(() {
      rememberMe = r;
      if (email != null && email.trim().isNotEmpty) {
        emailController.text = email.trim();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    klasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF050816), Color(0xFF09041A)],
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
                    colors: [Color(0xFF0F1535), Color(0xFF080A1A)],
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
                      DropdownButtonFormField<String>(
                        value: selectedOpleiding,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF141A2E),
                        icon: const Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.white.withOpacity(0.9),
                        style: const TextStyle(color: Colors.white),
                        decoration: _input('Opleiding'),
                        hint: Text(
                          'Kies opleiding',
                          style: TextStyle(color: Colors.white.withOpacity(0.55)),
                        ),
                        items: opleidingenMA
                            .map(
                              (o) => DropdownMenuItem<String>(
                                value: o,
                                child: Text(
                                  o,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => selectedOpleiding = value);
                        },
                        menuMaxHeight: 320,
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

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          activeColor: const Color(0xFF00F5FF),
                          checkColor: Colors.black,
                          onChanged: (v) {
                            setState(() => rememberMe = v ?? true);
                          },
                        ),
                        Text(
                          'Onthoud account',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    if (errorText != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        errorText!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFF4B91),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],

                    const SizedBox(height: 14),

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
                          onPressed: _forgotPassword,
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

  Future<void> _forgotPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() => errorText = 'Vul eerst je e-mail in.');
      return;
    }

    setState(() {
      loading = true;
      errorText = null;
    });

    final err = await AuthService.sendPasswordReset(email);

    if (!mounted) return;

    setState(() => loading = false);

    if (err != null) {
      setState(() => errorText = _mapError(err));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reset link is verstuurd naar je e-mail ✅')),
    );
  }

  Future<void> _submit() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    setState(() {
      loading = true;
      errorText = null;
    });

    if (email.isEmpty || !email.contains('@')) {
      setState(() {
        loading = false;
        errorText = 'Vul een geldige e-mail in.';
      });
      return;
    }

    if (pass.isEmpty || pass.length < 4) {
      setState(() {
        loading = false;
        errorText = 'Wachtwoord is te kort (minimaal 4).';
      });
      return;
    }

    if (isRegister) {
      final name = nameController.text.trim();
      final klas = klasController.text.trim();
      final opleiding = (selectedOpleiding ?? '').trim();

      if (name.isEmpty || klas.isEmpty || opleiding.isEmpty) {
        setState(() {
          loading = false;
          errorText = 'Vul alles in en kies een opleiding.';
        });
        return;
      }
    }

    String? err;

    if (isRegister) {
      err = await AuthService.register(
        email: email,
        password: pass,
        name: nameController.text.trim(),
        opleiding: (selectedOpleiding ?? '').trim(),
        klas: klasController.text.trim(),
      );
    } else {
      err = await AuthService.login(email: email, password: pass);
    }

    if (!mounted) return;

    if (err != null) {
  setState(() {
    loading = false;
    errorText = err;
  });
  return;
}


    await AuthService.setRememberMe(remember: rememberMe, email: email);

    final user = await AuthService.getSessionUser();

    if (!mounted) return;

    if (user == null) {
      setState(() {
        loading = false;
        errorText = 'Geen sessie gevonden. Probeer opnieuw.';
      });
      return;
    }

    AppState.currentUser = user;

    setState(() => loading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  String _mapError(String key) {
    if (key == 'invalid_email') return 'Ongeldige e-mail.';
    if (key == 'weak_password') return 'Wachtwoord is te kort (minimaal 4).';
    if (key == 'email_exists') return 'Deze e-mail bestaat al.';
    if (key == 'not_found') return 'Account niet gevonden. Maak eerst een account.';
    if (key == 'wrong_password') return 'Wachtwoord klopt niet.';
    if (key == 'not_logged_in') return 'Niet ingelogd. Probeer opnieuw.';
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
