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

  static void loginUser(String email) {
    currentUser = User(
      id: email,
      name: 'Student',
      opleiding: 'SD',
      klas: 'SD3B',
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
        note: noteText,
      ),
    );
  }

  static void addNote(String text) {
    if (currentUser == null) return;
    notes.add(
      Note(
        userId: currentUser!.id,
        date: DateTime.now(),
        text: text,
      ),
    );
  }
}
