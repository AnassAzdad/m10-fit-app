import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  // Simpele lijst met hulpopties
  List<_HelpItem> get _items => const [
        _HelpItem(
          title: 'Schoolbegeleider / Zorgteam',
          description:
              'Voor als het op school even niet gaat. Plan een gesprek of loop langs tijdens het spreekuur.',
          icon: Icons.school_rounded,
        ),
        _HelpItem(
          title: 'Decaan / SLB-docent',
          description:
              'Voor vragen over studie, planning, stage en keuzes die je moet maken.',
          icon: Icons.person_rounded,
        ),
        _HelpItem(
          title: 'Huisarts',
          description:
              'Bij klachten over je mentale of fysieke gezondheid. De huisarts kan je doorverwijzen.',
          icon: Icons.local_hospital_rounded,
        ),
        _HelpItem(
          title: 'Online chat / hulplijn',
          description:
              'Anoniem met iemand praten via chat. Vaak bereikbaar in de avonduren.',
          icon: Icons.chat_bubble_outline_rounded,
        ),
        _HelpItem(
          title: 'Nood / crisis',
          description:
              'Bij directe nood of als je jezelf niet veilig voelt: neem direct contact op met een hulplijn of bel 112.',
          icon: Icons.warning_amber_rounded,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hulp'),
        centerTitle: true,
      ),
      body: Container(
        // Zelfde zachte achtergrond als andere schermen
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5E8FF),
              Color(0xFFF7F8FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          // Mobile-first: scroll + max breedte
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hulp nodig?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Je hoeft het niet alleen te doen. Hier zijn een paar opties waar je terecht kunt:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Boxen met hulpopties
                  ..._items.map(
                    (item) => _HelpCard(item: item),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Modelletje
class _HelpItem {
  final String title;
  final String description;
  final IconData icon;

  const _HelpItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

// Eén kaart in dezelfde stijl als de rest
class _HelpCard extends StatelessWidget {
  final _HelpItem item;

  const _HelpCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: const Color(0xFF4F46E5),
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
