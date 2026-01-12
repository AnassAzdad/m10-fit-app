import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/quote.dart';

class QuoteService {
  static final SupabaseClient _supa = Supabase.instance.client;

  /* =========================
     GET QUOTES
  ========================== */
  static Future<List<AppQuote>> getQuotes({String? category}) async {
    try {
      // 👇 GEEN generics, gewoon Supabase standaard
      dynamic query = _supa.from('quotes').select();

      if (category != null && category != 'all') {
        query = query.eq('category', category);
      }

      final List<dynamic> res =
          await query.order('created_at', ascending: true);

      return res
          .map((e) =>
              AppQuote.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // ✅ examen-safe: app crasht NOOIT
      return [];
    }
  }

  /* =========================
     FAVORITES
  ========================== */
  static Future<Set<String>> getFavorites() async {
    final uid = _supa.auth.currentUser?.id;
    if (uid == null) return {};

    final List<dynamic> res = await _supa
        .from('quote_favorites')
        .select('quote_id')
        .eq('user_id', uid);

    return res
        .map((e) => e['quote_id'] as String)
        .toSet();
  }

  static Future<void> toggleFavorite({
    required String quoteId,
    required bool isFav,
  }) async {
    final uid = _supa.auth.currentUser?.id;
    if (uid == null) return;

    if (isFav) {
      await _supa
          .from('quote_favorites')
          .delete()
          .eq('user_id', uid)
          .eq('quote_id', quoteId);
    } else {
      await _supa.from('quote_favorites').insert({
        'user_id': uid,
        'quote_id': quoteId,
      });
    }
  }
}
