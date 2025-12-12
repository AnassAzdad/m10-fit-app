class Pillar {
  final String id;
  final String title;
  final String shortDescription;
  final String longDescription;
  final List<String> tips;

  Pillar({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.tips,
  });

  static List<Pillar> demoPillars = [
    Pillar(
      id: 'energy',
      title: 'Energie',
      shortDescription: 'Balans houden in je fysieke en mentale energie.',
      longDescription:
          'Een gezonde energiebalans helpt je om je studie en dagelijkse taken vol te houden. Denk aan beweging, voeding, pauzes en herstelmomenten.',
      tips: [
        'Neem korte beweegmomenten tussen lessen.',
        'Drink voldoende water.',
        'Plan regelmatig pauzes tijdens het studeren.',
      ],
    ),
    Pillar(
      id: 'emotions',
      title: 'Emoties',
      shortDescription: 'Leren omgaan met je gevoelens.',
      longDescription:
          'Emoties herkennen en benoemen is belangrijk voor je mentale gezondheid. Door er bewust mee om te gaan verminder je stress en spanning.',
      tips: [
        'Schrijf dagelijks op hoe je je voelt.',
        'Praat met iemand die je vertrouwt.',
        'Laat emoties toe zonder oordeel.',
      ],
    ),
    Pillar(
      id: 'focus',
      title: 'Focus',
      shortDescription: 'Concentratie en aandacht verbeteren.',
      longDescription:
          'Goede focus helpt je productiever te zijn. Door afleiding te verminderen en structuur te creëren kun je beter presteren.',
      tips: [
        'Werk in blokken van 25 minuten (Pomodoro).',
        'Zet je telefoon op niet storen.',
        'Werk in een rustige, opgeruimde ruimte.',
      ],
    ),
    Pillar(
      id: 'stress',
      title: 'Stress',
      shortDescription: 'Omgaan met druk en spanning.',
      longDescription:
          'Stress is normaal, maar te veel stress kan klachten veroorzaken. Door bewust ademhalen, rust nemen en overzicht te bewaren blijft stress beheersbaar.',
      tips: [
        'Doe elke dag 5 minuten ademhalingsoefeningen.',
        'Maak een to-do lijst voor overzicht.',
        'Plan tijd in voor ontspanning.',
      ],
    ),
    Pillar(
      id: 'sleep',
      title: 'Slaap',
      shortDescription: 'Een gezond slaapritme opbouwen.',
      longDescription:
          'Slaap is essentieel voor herstel, concentratie en humeur. Een vast ritme helpt je lichaam om beter te functioneren.',
      tips: [
        'Ga elke dag rond dezelfde tijd naar bed.',
        'Vermijd schermen een uur voor het slapen.',
        'Zorg dat je kamer donker en koel is.',
      ],
    ),
    Pillar(
      id: 'social',
      title: 'Sociale Verbinding',
      shortDescription: 'Verbinding met mensen om je heen.',
      longDescription:
          'Sociale contacten helpen bij motivatie, zelfvertrouwen en welzijn. Praten met anderen vermindert stress en geeft energie.',
      tips: [
        'Plan wekelijks iets met een vriend of klasgenoot.',
        'Zoek steun als je ergens mee zit.',
        'Deel successen en uitdagingen met anderen.',
      ],
    ),
    Pillar(
      id: 'planning',
      title: 'Planning & Studie',
      shortDescription: 'Structuur aanbrengen in je schoolwerk.',
      longDescription:
          'Een goede planning helpt om deadlines te halen en rust te bewaren. Het geeft overzicht en voorkomt stress.',
      tips: [
        'Maak aan het begin van de week een planning.',
        'Werk met deadlines per taak.',
        'Begin met kleine stappen om motivatie op te bouwen.',
      ],
    ),
    Pillar(
      id: 'confidence',
      title: 'Zelfvertrouwen',
      shortDescription: 'Groeien in je eigen kracht.',
      longDescription:
          'Zelfvertrouwen bouw je op door kleine doelen te halen, positief naar jezelf te kijken en trots te zijn op vooruitgang.',
      tips: [
        'Schrijf elke dag iets op dat goed ging.',
        'Vergelijk jezelf niet met anderen.',
        'Vier kleine en grote successen.',
      ],
    ),
  ];
}
