import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/network/error_model.dart';
import '../../data/models/quote_model.dart';

part 'quote_state.freezed.dart';


@freezed
class QuoteState with _$QuoteState {
  const factory QuoteState.initial() = _Initial;
  const factory QuoteState.loading() = QuoteLoading;
  const factory QuoteState.success(QuoteModel quotes) = QuoteSuccess;
  const factory QuoteState.error(ApiErrorModel apiErrorModel) = QuoteError;
}
