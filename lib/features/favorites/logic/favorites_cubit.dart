import 'package:flutter_bloc/flutter_bloc.dart';
import '../../quotes/data/models/quote_model.dart';
import '../data/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository repository;

  FavoritesCubit(this.repository) : super(const FavoritesState.initial());

  // Load all favorite quotes
  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());
    final favorites = await repository.getFavorites();
    emit(FavoritesSuccess(favorites));
  }

  // Add a quote to favorites
  Future<void> addFavorite(QuoteModel quote) async {
    await repository.addFavorite(quote);
    await loadFavorites();
  }

  // Remove a quote from favorites
  Future<void> removeFavorite(QuoteModel quote) async {
    await repository.removeFavorite(quote);
    await loadFavorites();
  }

  // Check if a quote is favorite (returns true if found)
  Future<bool> isFavorite(QuoteModel quote) async {
    return await repository.isFavorite(quote);
  }
} 