import 'package:flutter/material.dart';

import '../../core/app_state.dart';
import '../../core/localization.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = AppState.language;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          L.t('notes_title', lang),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        PrimaryCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: L.t('notes_hint', lang),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                label: L.t('save', lang),
                onPressed: () {
                  if (noteController.text.trim().isEmpty) return;
                  AppState.addNote(noteController.text.trim());
                  noteController.clear();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...AppState.notes.reversed.map(
          (n) => PrimaryCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${n.date.day}-${n.date.month}-${n.date.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(n.text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
