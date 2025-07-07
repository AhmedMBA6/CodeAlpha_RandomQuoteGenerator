import 'package:flutter_bloc/flutter_bloc.dart';
import '../../quotes/data/models/quote_model.dart';
import '../data/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(const FavoritesState.initial()) {
    // Auto-load favorites when the cubit is created (app startup)
    _initializeFavorites();
  }

  // Initialize favorites on app startup
  Future<void> _initializeFavorites() async {
    try {
      await loadFavorites();
    } catch (e) {
      // If loading fails, emit error state
      emit(FavoritesError('Failed to load favorites: ${e.toString()}'));
    }
  }

  // Load all favorite quotes
  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());
    try {
      final favorites = await repository.getFavorites();
      emit(FavoritesSuccess(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: ${e.toString()}'));
    }
  }

  // Add a quote to favorites
  Future<void> addFavorite(QuoteModel quote) async {
    try {
      await repository.addFavorite(quote);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError('Failed to add favorite: ${e.toString()}'));
    }
  }

  // Remove a quote from favorites
  Future<void> removeFavorite(QuoteModel quote) async {
    try {
      await repository.removeFavorite(quote);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError('Failed to remove favorite: ${e.toString()}'));
    }
  }

  // Check if a quote is favorite (returns true if found)
  Future<bool> isFavorite(QuoteModel quote) async {
    try {
      return await repository.isFavorite(quote);
    } catch (e) {
      // Return false if check fails
      return false;
    }
  }
} 