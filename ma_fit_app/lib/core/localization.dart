enum AppLanguage { nl, en }

class L {
  static String t(String key, AppLanguage lang) {
    final map = _localizedValues[lang] ?? {};
    return map[key] ?? key;
  }

  static final Map<AppLanguage, Map<String, String>> _localizedValues = {
    AppLanguage.nl: {
      'app_title': 'MA Fit',
      'home': 'Home',
      'welcome': 'Welkom terug',
      'how_feel': 'Hoe voel je je vandaag?',
      'pillars': 'Pijlers',
      'checkin': 'Check-in',
      'notes': 'Notities',
      'challenges': 'Challenges',
      'quotes': 'Quotes',
      'help': 'Hulp',
      'student': 'Student',
      'challenges_title': 'Challenges',
      'challenges_subtitle': 'Kies een challenge en bouw gezonde gewoontes op.',
      'filter_all': 'Alle',
      'filter_easy': 'Makkelijk',
      'filter_week': '7 dagen',
      'filter_focus': 'Focus',
      'filter_sleep': 'Slaap',
      'filter_stress': 'Stress',
      'btn_start': 'Start',
      'btn_view': 'Bekijk',
      'status_active': 'Bezig',
      'status_done': 'Klaar',
      'points': 'punten',
      'days': 'dagen',
    },
    AppLanguage.en: {
      'app_title': 'MA Fit',
      'home': 'Home',
      'welcome': 'Welcome back',
      'how_feel': 'How are you feeling today?',
      'pillars': 'Pillars',
      'checkin': 'Check-in',
      'notes': 'Notes',
      'challenges': 'Challenges',
      'quotes': 'Quotes',
      'help': 'Help',
      'student': 'Student',
      'challenges_title': 'Challenges',
      'challenges_subtitle': 'Pick a challenge and build healthy habits.',
      'filter_all': 'All',
      'filter_easy': 'Easy',
      'filter_week': '7 days',
      'filter_focus': 'Focus',
      'filter_sleep': 'Sleep',
      'filter_stress': 'Stress',
      'btn_start': 'Start',
      'btn_view': 'View',
      'status_active': 'Active',
      'status_done': 'Done',
      'points': 'points',
      'days': 'days',
    },
  };
}
