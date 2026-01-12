import 'package:flutter/material.dart';
import '../../core/notes_service.dart';
import '../../models/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final controller = TextEditingController();
  bool loading = true;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => loading = true);
    notes = await NotesService.getMyNotes();
    if (mounted) setState(() => loading = false);
  }

  Future<void> _addNote() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    await NotesService.addNote(text);
    controller.clear();
    await _loadNotes();
  }

  Future<void> _deleteNote(String id) async {
    await NotesService.deleteNote(id);
    await _loadNotes();
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}-'
        '${d.month.toString().padLeft(2, '0')} '
        '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ➕ ADD NOTE
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F1535), Color(0xFF080A1A)],
            ),
            border: Border.all(
              color: const Color(0xFF9B5CFF).withOpacity(0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notitie toevoegen',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Schrijf hier je gedachten…',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: const Color(0xFF141A2E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _addNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9B5CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Opslaan',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // 📜 NOTES LIST
        if (loading)
          const Center(child: CircularProgressIndicator())
        else if (notes.isEmpty)
          Text(
            'Nog geen notities.',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          )
        else
          ...notes.map((n) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF141A2E),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(n.createdAt),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      n.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Colors.redAccent),
                        onPressed: () => _deleteNote(n.id),
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }
}
