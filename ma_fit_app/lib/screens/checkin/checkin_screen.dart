import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_card.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  double mood = 3;
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          L.t('checkin_title', lang),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        PrimaryCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L.t('checkin_mood_label', lang)),
              Slider(
                value: mood,
                min: 1,
                max: 5,
                divisions: 4,
                label: mood.round().toString(),
                onChanged: (value) {
                  setState(() {
                    mood = value;
                  });
                },
              ),
              const SizedBox(height: 8),
              TextField(
                controller: noteController,
                maxLines: 2,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: L.t('checkin_note_hint', lang),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: L.t('save', lang),
                onPressed: () {
                  AppState.addCheckIn(mood.round(), noteController.text);
                  noteController.clear();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Recente check-ins',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...AppState.checkIns.reversed.map(
          (c) => PrimaryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${c.date.day}-${c.date.month}-${c.date.year} | mood: ${c.mood}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                if (c.note.isNotEmpty) Text(c.note),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
