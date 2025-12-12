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
      shortDescription: 'Je fysieke en mentale energie in balans.',
      longDescription:
          'Binnen deze pijler kijken we naar slaap, beweging, voeding en herstel. '
          'Het doel is dat jij je energiek genoeg voelt om je studie en privéleven vol te houden.',
      tips: [
        'Probeer elke dag rond dezelfde tijd naar bed te gaan.',
        'Plan korte beweegmomenten tussen je lessen door.',
        'Neem een echte pauze zonder scherm.',
      ],
    ),
    Pillar(
      id: 'emotions',
      title: 'Emoties',
      shortDescription: 'Leren omgaan met je gevoelens.',
      longDescription:
          'In deze pijler draait het om herkennen, benoemen en delen van emoties. '
          'Dat helpt om minder stress op te bouwen.',
      tips: [
        'Schrijf je gevoel van vandaag op.',
        'Praat met iemand die je vertrouwt.',
        'Sta even stil bij wat je voelt, zonder oordeel.',
      ],
    ),
  ];
}
