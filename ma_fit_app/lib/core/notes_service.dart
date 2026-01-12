import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/note.dart';
import '../core/app_state.dart';

class NotesService {
  static final SupabaseClient _supa = Supabase.instance.client;

  /// 📥 HAAL NOTITIES VAN INGELOGDE GEBRUIKER
  static Future<List<Note>> getMyNotes() async {
    final user = AppState.currentUser;
    if (user == null) return [];

    final res = await _supa
        .from('notes')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (res as List)
        .map(
          (row) => Note(
            id: row['id'],
            userId: row['user_id'],
            text: row['text'],
            createdAt: DateTime.parse(row['created_at']),
          ),
        )
        .toList();
  }

  /// ➕ VOEG NOTITIE TOE (MET DATUM & USER)
  static Future<void> addNote(String text) async {
    final user = AppState.currentUser;
    if (user == null) return;

    final t = text.trim();
    if (t.isEmpty) return;

    await _supa.from('notes').insert({
      'user_id': user.id,
      'text': t,
    });
  }

  /// 🗑️ VERWIJDER NOTITIE (ALLEEN EIGEN)
  static Future<void> deleteNote(String id) async {
    final user = AppState.currentUser;
    if (user == null) return;

    await _supa
        .from('notes')
        .delete()
        .eq('id', id)
        .eq('user_id', user.id);
  }
}
