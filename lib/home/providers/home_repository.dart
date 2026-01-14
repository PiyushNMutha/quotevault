import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/quote_model.dart';
import '../models/category_model.dart';

class HomeRepository {
  final _client = Supabase.instance.client;

  /// Quote of the Day
  Future<Quote> fetchQuoteOfTheDay() async {
    final response = await _client
        .from('quotes')
        .select()
        .order('created_at')
        .limit(1);

    return Quote.fromMap(response.first);
  }

  /// Fetch categories dynamically
  Future<List<Category>> fetchCategories() async {
    final response = await _client
        .from('quotes')
        .select('category')
        .order('category');

    final uniqueCategories = response
        .map<String>((e) => e['category'] as String)
        .toSet()
        .toList();

    return uniqueCategories
        .map((c) => Category(name: c))
        .toList();
  }

  /// Fetch quotes with filters
  Future<List<Quote>> fetchQuotes({
    String? category,
    String? search,
  }) async {
    var query = _client.from('quotes').select();

    if (category != null && category.isNotEmpty) {
      query = query.eq('category', category);
    }

    if (search != null && search.isNotEmpty) {
      query = query.ilike('text', '%$search%');
    }

    final response = await query.limit(30);
    return response.map<Quote>((e) => Quote.fromMap(e)).toList();
  }
}
