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
    },
  };
}
