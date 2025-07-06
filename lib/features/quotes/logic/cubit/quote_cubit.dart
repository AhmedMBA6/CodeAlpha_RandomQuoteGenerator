import 'package:flutter_bloc/flutter_bloc.dart';
import 'quote_state.dart';
import '../../data/repos/quote_repository.dart';
import '../../../../core/network/api_result.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteRepository repository;
  // Tracks if a quote has been loaded to distinguish between initial and subsequent loads
  bool _hasLoadedQuote = false;

  QuoteCubit(this.repository) : super(const QuoteState.initial());

  // Fetches a random quote and emits appropriate loading and result states
  Future<void> fetchRandomQuote() async {
    if (!_hasLoadedQuote) {
      // Emit loading state for initial load
      emit(const QuoteState.loading(isInitial: true));
    } else {
      // Emit loading state for fetching a new quote
      emit(const QuoteState.loading(isInitial: false));
    }

    final result = await repository.getRandomQuote();

    result.when(
      success: (quote) {
        _hasLoadedQuote = true;
        emit(QuoteState.success(quote));
      },
      failure: (error) => emit(QuoteState.error(error)),
    );
  }
}
