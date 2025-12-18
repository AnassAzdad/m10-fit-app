import '../core/app_state.dart';
import '../core/localization.dart';

class Pillar {
  final String id;

  final String titleNl;
  final String titleEn;

  final String shortNl;
  final String shortEn;

  final String longNl;
  final String longEn;

  final List<String> tipsNl;
  final List<String> tipsEn;

  Pillar({
    required this.id,
    required this.titleNl,
    required this.titleEn,
    required this.shortNl,
    required this.shortEn,
    required this.longNl,
    required this.longEn,
    required this.tipsNl,
    required this.tipsEn,
  });

  String get title =>
      AppState.language == AppLanguage.en ? titleEn : titleNl;

  String get shortDescription =>
      AppState.language == AppLanguage.en ? shortEn : shortNl;

  String get longDescription =>
      AppState.language == AppLanguage.en ? longEn : longNl;

  List<String> get tips =>
      AppState.language == AppLanguage.en ? tipsEn : tipsNl;

  static List<Pillar> demoPillars = [
    Pillar(
      id: 'energy',
      titleNl: 'Energie',
      titleEn: 'Energy',
      shortNl: 'Balans houden in je fysieke en mentale energie.',
      shortEn: 'Maintain balance in your physical and mental energy.',
      longNl:
          'Een gezonde energiebalans helpt je om je studie en dagelijkse taken vol te houden. Denk aan beweging, voeding, pauzes en herstelmomenten.',
      longEn:
          'A healthy energy balance helps you keep up with studying and daily tasks. Think about movement, nutrition, breaks, and recovery moments.',
      tipsNl: [
        'Neem korte beweegmomenten tussen lessen.',
        'Drink voldoende water.',
        'Plan regelmatig pauzes tijdens het studeren.',
      ],
      tipsEn: [
        'Take short movement breaks between classes.',
        'Drink enough water.',
        'Plan regular breaks while studying.',
      ],
    ),
    Pillar(
      id: 'emotions',
      titleNl: 'Emoties',
      titleEn: 'Emotions',
      shortNl: 'Leren omgaan met je gevoelens.',
      shortEn: 'Learn to deal with your feelings.',
      longNl:
          'Emoties herkennen en benoemen is belangrijk voor je mentale gezondheid. Door er bewust mee om te gaan verminder je stress en spanning.',
      longEn:
          'Recognizing and naming emotions is important for your mental health. Handling them consciously can reduce stress and tension.',
      tipsNl: [
        'Schrijf dagelijks op hoe je je voelt.',
        'Praat met iemand die je vertrouwt.',
        'Laat emoties toe zonder oordeel.',
      ],
      tipsEn: [
        'Write down how you feel each day.',
        'Talk to someone you trust.',
        'Allow emotions without judgment.',
      ],
    ),
    Pillar(
      id: 'focus',
      titleNl: 'Focus',
      titleEn: 'Focus',
      shortNl: 'Concentratie en aandacht verbeteren.',
      shortEn: 'Improve concentration and attention.',
      longNl:
          'Goede focus helpt je productiever te zijn. Door afleiding te verminderen en structuur te creëren kun je beter presteren.',
      longEn:
          'Good focus helps you be more productive. By reducing distractions and creating structure, you can perform better.',
      tipsNl: [
        'Werk in blokken van 25 minuten (Pomodoro).',
        'Zet je telefoon op niet storen.',
        'Werk in een rustige, opgeruimde ruimte.',
      ],
      tipsEn: [
        'Work in 25-minute blocks (Pomodoro).',
        'Put your phone on Do Not Disturb.',
        'Work in a quiet, tidy space.',
      ],
    ),
    Pillar(
      id: 'stress',
      titleNl: 'Stress',
      titleEn: 'Stress',
      shortNl: 'Omgaan met druk en spanning.',
      shortEn: 'Deal with pressure and tension.',
      longNl:
          'Stress is normaal, maar te veel stress kan klachten veroorzaken. Door bewust ademhalen, rust nemen en overzicht te bewaren blijft stress beheersbaar.',
      longEn:
          'Stress is normal, but too much stress can cause problems. With mindful breathing, rest, and keeping overview, stress stays manageable.',
      tipsNl: [
        'Doe elke dag 5 minuten ademhalingsoefeningen.',
        'Maak een to-do lijst voor overzicht.',
        'Plan tijd in voor ontspanning.',
      ],
      tipsEn: [
        'Do 5 minutes of breathing exercises daily.',
        'Make a to-do list to stay organized.',
        'Schedule time for relaxation.',
      ],
    ),
    Pillar(
      id: 'sleep',
      titleNl: 'Slaap',
      titleEn: 'Sleep',
      shortNl: 'Een gezond slaapritme opbouwen.',
      shortEn: 'Build a healthy sleep routine.',
      longNl:
          'Slaap is essentieel voor herstel, concentratie en humeur. Een vast ritme helpt je lichaam om beter te functioneren.',
      longEn:
          'Sleep is essential for recovery, focus, and mood. A consistent routine helps your body function better.',
      tipsNl: [
        'Ga elke dag rond dezelfde tijd naar bed.',
        'Vermijd schermen een uur voor het slapen.',
        'Zorg dat je kamer donker en koel is.',
      ],
      tipsEn: [
        'Go to bed around the same time every day.',
        'Avoid screens one hour before sleep.',
        'Keep your room dark and cool.',
      ],
    ),
    Pillar(
      id: 'social',
      titleNl: 'Sociale Verbinding',
      titleEn: 'Social Connection',
      shortNl: 'Verbinding met mensen om je heen.',
      shortEn: 'Connect with people around you.',
      longNl:
          'Sociale contacten helpen bij motivatie, zelfvertrouwen en welzijn. Praten met anderen vermindert stress en geeft energie.',
      longEn:
          'Social connections support motivation, confidence, and well-being. Talking with others reduces stress and gives energy.',
      tipsNl: [
        'Plan wekelijks iets met een vriend of klasgenoot.',
        'Zoek steun als je ergens mee zit.',
        'Deel successen en uitdagingen met anderen.',
      ],
      tipsEn: [
        'Plan something weekly with a friend or classmate.',
        'Ask for support when something is on your mind.',
        'Share successes and challenges with others.',
      ],
    ),
    Pillar(
      id: 'planning',
      titleNl: 'Planning & Studie',
      titleEn: 'Planning & Study',
      shortNl: 'Structuur aanbrengen in je schoolwerk.',
      shortEn: 'Bring structure to your schoolwork.',
      longNl:
          'Een goede planning helpt om deadlines te halen en rust te bewaren. Het geeft overzicht en voorkomt stress.',
      longEn:
          'Good planning helps you meet deadlines and stay calm. It gives overview and prevents stress.',
      tipsNl: [
        'Maak aan het begin van de week een planning.',
        'Werk met deadlines per taak.',
        'Begin met kleine stappen om motivatie op te bouwen.',
      ],
      tipsEn: [
        'Make a weekly plan at the start of the week.',
        'Use deadlines per task.',
        'Start with small steps to build motivation.',
      ],
    ),
    Pillar(
      id: 'confidence',
      titleNl: 'Zelfvertrouwen',
      titleEn: 'Self-Confidence',
      shortNl: 'Groeien in je eigen kracht.',
      shortEn: 'Grow in your own strength.',
      longNl:
          'Zelfvertrouwen bouw je op door kleine doelen te halen, positief naar jezelf te kijken en trots te zijn op vooruitgang.',
      longEn:
          'You build confidence by achieving small goals, having a positive view of yourself, and being proud of progress.',
      tipsNl: [
        'Schrijf elke dag iets op dat goed ging.',
        'Vergelijk jezelf niet met anderen.',
        'Vier kleine en grote successen.',
      ],
      tipsEn: [
        'Write down something that went well each day.',
        'Do not compare yourself to others.',
        'Celebrate small and big wins.',
      ],
    ),
  ];
}
