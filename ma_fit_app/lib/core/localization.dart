enum AppLanguage { nl, en }

class L {
  static final Map<String, Map<AppLanguage, String>> _strings = {
    'app_title': {
      AppLanguage.nl: 'MA Fit',
      AppLanguage.en: 'MA Fit',
    },
    'welcome_title': {
      AppLanguage.nl: 'Welkom bij MA Fit',
      AppLanguage.en: 'Welcome to MA Fit',
    },
    'welcome_subtitle': {
      AppLanguage.nl:
          'Een mentale health app voor studenten van het Mediacollege Amsterdam.',
      AppLanguage.en:
          'A mental health app for students of the Mediacollege Amsterdam.',
    },
    'login_title': {
      AppLanguage.nl: 'Log in om te starten',
      AppLanguage.en: 'Log in to get started',
    },
    'email_label': {
      AppLanguage.nl: 'Schoolmail of studentnummer',
      AppLanguage.en: 'School email or student ID',
    },
    'password_label': {
      AppLanguage.nl: 'Wachtwoord',
      AppLanguage.en: 'Password',
    },
    'login_button': {
      AppLanguage.nl: 'Inloggen',
      AppLanguage.en: 'Log in',
    },
    'home_tab_overview': {
      AppLanguage.nl: 'Home',
      AppLanguage.en: 'Home',
    },
    'home_tab_pillars': {
      AppLanguage.nl: 'Pijlers',
      AppLanguage.en: 'Pillars',
    },
    'home_tab_checkin': {
      AppLanguage.nl: 'Check-in',
      AppLanguage.en: 'Check-in',
    },
    'home_tab_notes': {
      AppLanguage.nl: 'Notities',
      AppLanguage.en: 'Notes',
    },
    'home_tab_more': {
      AppLanguage.nl: 'Meer',
      AppLanguage.en: 'More',
    },
    'checkin_title': {
      AppLanguage.nl: 'Hoe gaat het vandaag?',
      AppLanguage.en: 'How are you today?',
    },
    'checkin_mood_label': {
      AppLanguage.nl: 'Je mood (1 = slecht, 5 = top)',
      AppLanguage.en: 'Your mood (1 = low, 5 = great)',
    },
    'checkin_note_hint': {
      AppLanguage.nl: 'Wil je er iets bij vertellen?',
      AppLanguage.en: 'Want to add something?',
    },
    'save': {
      AppLanguage.nl: 'Opslaan',
      AppLanguage.en: 'Save',
    },
    'notes_title': {
      AppLanguage.nl: 'Notitieboek',
      AppLanguage.en: 'Notebook',
    },
    'notes_hint': {
      AppLanguage.nl: 'Schrijf hier je gedachten van vandaag...',
      AppLanguage.en: 'Write your thoughts for today...',
    },
    'pillars_title': {
      AppLanguage.nl: 'Brain Balance pijlers',
      AppLanguage.en: 'Brain Balance pillars',
    },
    'challenges_title': {
      AppLanguage.nl: 'Challenges',
      AppLanguage.en: 'Challenges',
    },
    'quotes_title': {
      AppLanguage.nl: 'Quotes',
      AppLanguage.en: 'Quotes',
    },
    'help_title': {
      AppLanguage.nl: 'Hulp & informatie',
      AppLanguage.en: 'Help & information',
    },
  };

  static String t(String key, AppLanguage lang) {
    return _strings[key]?[lang] ?? key;
  }
}
