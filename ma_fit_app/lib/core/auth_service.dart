import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthService {
  static const _rememberMeKey = 'remember_me';
  static const _rememberEmailKey = 'remember_email';

  static final SupabaseClient _supa = Supabase.instance.client;

  /* =========================
     REMEMBER ME
  ========================== */

  static Future<void> setRememberMe({
    required bool remember,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, remember);

    if (remember) {
      await prefs.setString(_rememberEmailKey, email.trim());
    } else {
      await prefs.remove(_rememberEmailKey);
    }
  }

  static Future<bool> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  static Future<String?> getRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rememberEmailKey);
  }

  /* =========================
     REGISTER ✅ FIXED
  ========================== */

  static Future<String?> register({
    required String email,
    required String password,
    required String name,
    required String opleiding,
    required String klas,
  }) async {
    try {
      final res = await _supa.auth.signUp(
        email: email.trim(),
        password: password,
      );

      final user = res.user;
      if (user == null) {
        return 'signup_failed';
      }

      // ✅ WACHT tot auth.uid() actief is
      await Future.delayed(const Duration(milliseconds: 300));

      // ✅ UPsert i.p.v. insert (RLS-safe)
      await _supa.from('profiles').upsert(
        {
          'id': user.id, // MOET = auth.uid()
          'name': name.trim().isEmpty ? 'Student' : name.trim(),
          'opleiding': opleiding.trim(),
          'klas': klas.trim(),
        },
        onConflict: 'id',
      );

      return null; // succes
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  /* =========================
     LOGIN
  ========================== */

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _supa.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (res.session == null) {
        return 'no_session_returned';
      }

      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  /* =========================
     LOGOUT
  ========================== */

  static Future<void> logout() async {
    await _supa.auth.signOut();
  }

  /* =========================
     SESSION USER
  ========================== */

  static Future<User?> getSessionUser() async {
    final authUser = _supa.auth.currentUser;
    if (authUser == null) return null;

    try {
      final row = await _supa
          .from('profiles')
          .select('id, name, opleiding, klas')
          .eq('id', authUser.id)
          .single();

      return User(
        id: row['id'],
        name: row['name'] ?? 'Student',
        opleiding: row['opleiding'] ?? '',
        klas: row['klas'] ?? '',
      );
    } catch (_) {
      return User(
        id: authUser.id,
        name: 'Student',
        opleiding: '',
        klas: '',
      );
    }
  }

  /* =========================
     PASSWORD RESET
  ========================== */

  static Future<String?> sendPasswordReset(String email) async {
    try {
      await _supa.auth.resetPasswordForEmail(email.trim());
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
