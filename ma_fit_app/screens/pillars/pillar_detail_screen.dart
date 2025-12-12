import 'package:flutter/material.dart';

import '../../models/pillar.dart';
import '../../widgets/primary_card.dart';

class PillarDetailScreen extends StatelessWidget {
  final Pillar pillar;

  const PillarDetailScreen({super.key, required this.pillar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pillar.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            pillar.longDescription,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tips',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...pillar.tips.map(
            (t) => PrimaryCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  const SizedBox(width: 4),
                  Expanded(child: Text(t)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
