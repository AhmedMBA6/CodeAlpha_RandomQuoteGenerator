import 'package:flutter_bloc/flutter_bloc.dart';
import 'quote_state.dart';
import '../../data/repos/quote_repository.dart';
import '../../../../core/network/api_result.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteRepository repository;

  QuoteCubit(this.repository) : super(const QuoteState.initial());

  Future<void> fetchRandomQuote() async {
    emit(const QuoteState.loading());

    final result = await repository.getRandomQuote();

    result.when(
      success: (quote) => emit(QuoteState.success(quote)),
      failure: (error) => emit(QuoteState.error(error)),
    );
  }
}
