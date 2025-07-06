import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/error_model.dart';
import '../../data/models/quote_model.dart';

part 'quote_state.freezed.dart';

// QuoteState represents all possible states for the quote feature.
// The loading state uses the isInitial parameter to distinguish between initial loading and fetching a new quote.
@freezed
class QuoteState with _$QuoteState {
  const factory QuoteState.initial() = _Initial;
  // isInitial: true for first load, false for fetching a new quote
  const factory QuoteState.loading({@Default(false) bool isInitial}) = QuoteLoading;
  const factory QuoteState.success(QuoteModel quotes) = QuoteSuccess;
  const factory QuoteState.error(ApiErrorModel apiErrorModel) = QuoteError;
}
