import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/supabase_provider.dart';

final favoritesProvider =
AsyncNotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    final client = ref.read(supabaseProvider);
    final user = client.auth.currentUser;
    if (user == null) return {};

    final res = await client
        .from('user_favorites')
        .select('quote_id')
        .eq('user_id', user.id);

    return res.map<String>((e) => e['quote_id']).toSet();
  }

  Future<void> toggleFavorite(String quoteId) async {
    final client = ref.read(supabaseProvider);
    final user = client.auth.currentUser!;
    final current = state.value ?? {};

    if (current.contains(quoteId)) {
      await client.from('user_favorites').delete().match({
        'user_id': user.id,
        'quote_id': quoteId,
      });
      state = AsyncData({...current}..remove(quoteId));
    } else {
      await client.from('user_favorites').insert({
        'user_id': user.id,
        'quote_id': quoteId,
      });
      state = AsyncData({...current, quoteId});
    }
  }
}
