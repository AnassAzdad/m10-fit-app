import 'package:supabase_flutter/supabase_flutter.dart';

class CheckinStats {
  final int totalToday;
  final int opleidingToday;

  CheckinStats({
    required this.totalToday,
    required this.opleidingToday,
  });
}

class LeaderboardRow {
  final String opleiding;
  final int count;

  LeaderboardRow({
    required this.opleiding,
    required this.count,
  });
}

class StatsService {
  static final _supabase = Supabase.instance.client;

  static Future<CheckinStats> getTodayStats({
    required DateTime day,
    required String opleiding,
  }) async {
    final date = DateTime(day.year, day.month, day.day).toIso8601String().substring(0, 10);

    final res = await _supabase.rpc('get_checkin_stats', params: {
      'p_day': date,
      'p_opleiding': opleiding,
    });

    final data = (res as Map).cast<String, dynamic>();
    return CheckinStats(
      totalToday: (data['total_today'] ?? 0) as int,
      opleidingToday: (data['opleiding_today'] ?? 0) as int,
    );
  }

  static Future<List<LeaderboardRow>> getTodayLeaderboard({required DateTime day}) async {
    final date = DateTime(day.year, day.month, day.day).toIso8601String().substring(0, 10);

    final res = await _supabase.rpc('get_checkin_leaderboard', params: {
      'p_day': date,
    });

    final list = (res as List).cast<dynamic>();
    return list
        .map((e) => (e as Map).cast<String, dynamic>())
        .map(
          (m) => LeaderboardRow(
            opleiding: (m['opleiding'] ?? '').toString().isEmpty ? 'Onbekend' : (m['opleiding'] as String),
            count: (m['count'] ?? 0) as int,
          ),
        )
        .toList();
  }
}
