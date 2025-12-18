import '../models/user.dart';
import '../models/pillar.dart';
import '../models/challenge.dart';
import '../models/quote.dart';
import '../models/checkin.dart';
import '../models/note.dart';
import 'localization.dart';

class AppState {
  static AppLanguage language = AppLanguage.nl;
  static User? currentUser;

  static List<Pillar> pillars = Pillar.demoPillars;
  static List<Challenge> challenges = Challenge.demoChallenges;
  static List<AppQuote> quotes = AppQuote.demoQuotes;

  static List<CheckIn> checkIns = [];
  static List<Note> notes = [];

  static void loginUser(String name, String opleiding, String klas) {
    currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim().isEmpty ? 'Student' : name.trim(),
      opleiding: opleiding.trim(),
      klas: klas.trim(),
    );
  }

  static void logoutUser() {
    currentUser = null;
    checkIns = [];
    notes = [];
  }

  static void addCheckIn(int mood, String noteText) {
    if (currentUser == null) return;

    checkIns.add(
      CheckIn(
        userId: currentUser!.id,
        opleiding: currentUser!.opleiding,
        klas: currentUser!.klas,
        date: DateTime.now(),
        mood: mood,
        note: noteText.trim(),
      ),
    );
  }

  static void addNote(String text) {
    if (currentUser == null) return;

    final t = text.trim();
    if (t.isEmpty) return;

    notes.add(
      Note(
        userId: currentUser!.id,
        date: DateTime.now(),
        text: t,
      ),
    );
  }

  static List<CheckIn> getMyCheckIns() {
    if (currentUser == null) return [];
    return checkIns.where((c) => c.userId == currentUser!.id).toList();
  }

  static List<Note> getMyNotes() {
    if (currentUser == null) return [];
    return notes.where((n) => n.userId == currentUser!.id).toList();
  }

  static int getTodayCountForClass(String opleiding, String klas) {
    final now = DateTime.now();
    return checkIns.where((c) {
      final sameClass = c.opleiding == opleiding && c.klas == klas;
      final sameDay = c.date.year == now.year && c.date.month == now.month && c.date.day == now.day;
      return sameClass && sameDay;
    }).length;
  }

  static double getTodayAverageMoodForClass(String opleiding, String klas) {
    final now = DateTime.now();
    final items = checkIns.where((c) {
      final sameClass = c.opleiding == opleiding && c.klas == klas;
      final sameDay = c.date.year == now.year && c.date.month == now.month && c.date.day == now.day;
      return sameClass && sameDay;
    }).toList();

    if (items.isEmpty) return 0;

    final sum = items.fold<int>(0, (a, b) => a + b.mood);
    return sum / items.length;
  }
}
