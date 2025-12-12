class Challenge {
  final String id;
  final String title;
  final String description;
  final String goal;
  final List<String> steps;
  final int durationDays;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.steps,
    required this.durationDays,
  });

  static List<Challenge> demoChallenges = [
    Challenge(
      id: 'screenbreak',
      title: 'Schermpauze challenge',
      description:
          'Neem elke dag één uur zonder telefoon of computer buiten school om.',
      goal: 'Minder overprikkeling en meer rust in je hoofd.',
      steps: [
        'Kies een vast moment op de dag.',
        'Leg je telefoon uit zicht.',
        'Doe iets wat je ontspant: wandelen, muziek luisteren, tekenen.',
      ],
      durationDays: 7,
    ),
    Challenge(
      id: 'sleep',
      title: 'Slaapritme challenge',
      description: '7 dagen op dezelfde tijd naar bed.',
      goal: 'Een rustiger slaapritme en meer energie overdag.',
      steps: [
        'Kies een vaste bedtijd.',
        'Zet een reminder 30 minuten van tevoren.',
        'Leg schermen weg voordat je gaat slapen.',
      ],
      durationDays: 7,
    ),
  ];
}
