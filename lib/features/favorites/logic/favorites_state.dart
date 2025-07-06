import 'package:freezed_annotation/freezed_annotation.dart';
import '../../quotes/data/models/quote_model.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  const factory FavoritesState.initial() = _Initial;
  const factory FavoritesState.loading() = FavoritesLoading;
  const factory FavoritesState.success(List<QuoteModel> favorites) = FavoritesSuccess;
  const factory FavoritesState.error(String message) = FavoritesError;
} 