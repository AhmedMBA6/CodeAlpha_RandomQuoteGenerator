import 'dart:convert';

import '../../quotes/data/models/quote_model.dart';
import 'package:codealpha_random_quote_generator/core/utils/shared_prefs_service.dart';
import 'package:codealpha_random_quote_generator/core/di/injection_container.dart';

class FavoritesRepository {
  static const String _favoritesKey = 'favorite_quotes';
  final SharedPrefsService _prefsService;

  FavoritesRepository([SharedPrefsService? prefsService])
      : _prefsService = prefsService ?? getIt<SharedPrefsService>();

  // Fetch all favorite quotes
  Future<List<QuoteModel>> getFavorites() async {
    final List<String> jsonList = _prefsService.getStringList(_favoritesKey);
    if (jsonList.isEmpty) return [];
    return jsonList.map((jsonStr) => QuoteModel.fromJson(json.decode(jsonStr) as Map<String, dynamic>)).toList();
  }

  // Add a quote to favorites
  Future<void> addFavorite(QuoteModel quote) async {
    final List<String> jsonList = _prefsService.getStringList(_favoritesKey);
    final quoteJson = json.encode(quote.toJson());
    if (!jsonList.contains(quoteJson)) {
      jsonList.add(quoteJson);
      await _prefsService.setStringList(_favoritesKey, jsonList);
    }
  }

  // Remove a quote from favorites
  Future<void> removeFavorite(QuoteModel quote) async {
    final List<String> jsonList = _prefsService.getStringList(_favoritesKey);
    final quoteJson = json.encode(quote.toJson());
    jsonList.remove(quoteJson);
    await _prefsService.setStringList(_favoritesKey, jsonList);
  }

  // Check if a quote is in favorites
  Future<bool> isFavorite(QuoteModel quote) async {
    final List<String> jsonList = _prefsService.getStringList(_favoritesKey);
    final quoteJson = json.encode(quote.toJson());
    return jsonList.contains(quoteJson);
  }
} 