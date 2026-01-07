import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthService {
  static const _usersKey = 'users';
  static const _sessionKey = 'session_user_id';

  static Future<Map<String, dynamic>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_usersKey);
    if (raw == null || raw.trim().isEmpty) return {};
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Future<void> _saveUsers(Map<String, dynamic> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  static Future<User?> getSessionUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_sessionKey);
    if (id == null) return null;

    final users = await _loadUsers();
    final u = users[id];
    if (u == null) return null;

    return User(
      id: id,
      name: u['name'] ?? 'Student',
      opleiding: u['opleiding'] ?? '',
      klas: u['klas'] ?? '',
    );
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  static Future<String?> register({
    required String email,
    required String password,
    required String name,
    required String opleiding,
    required String klas,
  }) async {
    final users = await _loadUsers();
    final id = email.trim().toLowerCase();

    if (id.isEmpty || !id.contains('@')) return 'invalid_email';
    if (password.trim().length < 4) return 'weak_password';
    if (users.containsKey(id)) return 'email_exists';

    users[id] = {
      'name': name.trim().isEmpty ? 'Student' : name.trim(),
      'opleiding': opleiding.trim(),
      'klas': klas.trim(),
      'password': password,
    };

    await _saveUsers(users);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, id);

    return null;
  }

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    final users = await _loadUsers();
    final id = email.trim().toLowerCase();

    final u = users[id];
    if (u == null) return 'not_found';
    if ((u['password'] ?? '') != password) return 'wrong_password';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, id);

    return null;
  }
}
