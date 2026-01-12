import '../models/user.dart';
import '../models/pillar.dart';
import '../models/challenge.dart';
import '../models/quote.dart';
import '../models/checkin.dart';
import 'localization.dart';

class AppState {
  static AppLanguage language = AppLanguage.nl;

  /// 🔐 Ingelogde Supabase gebruiker
  static User? currentUser;

  /// Demo / vaste data
  static List<Pillar> pillars = Pillar.demoPillars;
  static List<Challenge> challenges = Challenge.demoChallenges;
  static List<AppQuote> quotes = AppQuote.demoQuotes;

  /// Check-ins (kan later ook Supabase worden)
  static List<CheckIn> checkIns = [];

  /* =========================
     AUTH / USER STATE
  ========================== */

  /// Wordt aangeroepen NA login/register via Supabase
  static void setUserFromSupabase({
    required String id,
    required String name,
    required String opleiding,
    required String klas,
  }) {
    currentUser = User(
      id: id, // ⚠️ dit is auth.uid()
      name: name.trim().isEmpty ? 'Student' : name.trim(),
      opleiding: opleiding.trim(),
      klas: klas.trim(),
    );
  }

  static void logoutUser() {
    currentUser = null;
    checkIns.clear();
  }

  /* =========================
     CHECK-INS (prototype / service)
  ========================== */

  static void addCheckIn(int mood, String noteText) {
    if (currentUser == null) return;

    checkIns.add(
      CheckIn(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: currentUser!.id,
        opleiding: currentUser!.opleiding,
        klas: currentUser!.klas,
        date: DateTime.now(),
        mood: mood,
        note: noteText.trim(),
      ),
    );
  }

  static List<CheckIn> getMyCheckIns() {
    if (currentUser == null) return [];
    return checkIns.where((c) => c.userId == currentUser!.id).toList();
  }

  static int getTodayCountForClass(String opleiding, String klas) {
    final now = DateTime.now();
    return checkIns.where((c) {
      final sameClass = c.opleiding == opleiding && c.klas == klas;
      final sameDay =
          c.date.year == now.year &&
          c.date.month == now.month &&
          c.date.day == now.day;
      return sameClass && sameDay;
    }).length;
  }

  static double getTodayAverageMoodForClass(String opleiding, String klas) {
    final now = DateTime.now();
    final items = checkIns.where((c) {
      final sameClass = c.opleiding == opleiding && c.klas == klas;
      final sameDay =
          c.date.year == now.year &&
          c.date.month == now.month &&
          c.date.day == now.day;
      return sameClass && sameDay;
    }).toList();

    if (items.isEmpty) return 0;

    final sum = items.fold<int>(0, (a, b) => a + b.mood);
    return sum / items.length;
  }
}
