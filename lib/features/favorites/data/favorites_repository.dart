import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../quotes/data/models/quote_model.dart';

class FavoritesRepository {
  static const String _favoritesKey = 'favorite_quotes';

  // Fetch all favorite quotes
  Future<List<QuoteModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_favoritesKey);
    if (jsonList == null) return [];
    return jsonList.map((jsonStr) => QuoteModel.fromJson(json.decode(jsonStr) as Map<String, dynamic>)).toList();
  }

  // Add a quote to favorites
  Future<void> addFavorite(QuoteModel quote) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = prefs.getStringList(_favoritesKey) ?? [];
    final quoteJson = json.encode(quote.toJson());
    if (!jsonList.contains(quoteJson)) {
      jsonList.add(quoteJson);
      await prefs.setStringList(_favoritesKey, jsonList);
    }
  }

  // Remove a quote from favorites
  Future<void> removeFavorite(QuoteModel quote) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = prefs.getStringList(_favoritesKey) ?? [];
    final quoteJson = json.encode(quote.toJson());
    jsonList.remove(quoteJson);
    await prefs.setStringList(_favoritesKey, jsonList);
  }

  // Check if a quote is in favorites
  Future<bool> isFavorite(QuoteModel quote) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = prefs.getStringList(_favoritesKey) ?? [];
    final quoteJson = json.encode(quote.toJson());
    return jsonList.contains(quoteJson);
  }
} 