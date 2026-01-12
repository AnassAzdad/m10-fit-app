import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ma_fit_app/models/checkin.dart';

class CheckInService {
  static final _db = Supabase.instance.client;

  static Future<void> addCheckIn({
    required int mood,
    required String note,
    required String opleiding,
    required String klas,
  }) async {
    final user = _db.auth.currentUser;
    if (user == null) {
      throw Exception('not_logged_in');
    }

    await _db.from('checkins').insert({
      'user_id': user.id,
      'mood': mood,
      'note': note,
      'opleiding': opleiding,
      'klas': klas,
    });
  }

  static Future<List<CheckIn>> getMyCheckIns() async {
    final user = _db.auth.currentUser;
    if (user == null) return [];

    final rows = await _db
        .from('checkins')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (rows as List)
        .map((m) => CheckIn.fromMap(m as Map<String, dynamic>))
        .toList();
  }

  static Future<bool> hasCheckedInToday() async {
    final user = _db.auth.currentUser;
    if (user == null) return false;

    final now = DateTime.now().toUtc();
    final start = DateTime.utc(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));

    final rows = await _db
        .from('checkins')
        .select('id')
        .eq('user_id', user.id)
        .gte('created_at', start.toIso8601String())
        .lt('created_at', end.toIso8601String())
        .limit(1);

    return (rows as List).isNotEmpty;
  }
}
