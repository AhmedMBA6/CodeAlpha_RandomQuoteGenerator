import 'package:codealpha_random_quote_generator/core/network/api_client.dart';
import 'package:codealpha_random_quote_generator/core/network/api_error_handler.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/models/quote_model.dart';

import '../../../../core/network/api_result.dart';
import '../../../../core/network/error_model.dart';

class QuoteRepository {
  final ApiClient _apiClient;
  QuoteRepository(this._apiClient);
  Future<ApiResult<List<QuoteModel>>> getAllQuotes() async {
    try {
      final response = await _apiClient.getAllQuotes();
      return ApiResult.success(response);
    } catch (error) {
      return ApiErrorHandler.handle(error);
    }
  }

  Future<ApiResult<QuoteModel>> getRandomQuote() async {
  try {
    final list = await _apiClient.getRandomQuote();
    if (list.isNotEmpty) {
      return ApiResult.success(list.first);
    } else {
      return ApiResult.failure(ApiErrorModel(statusMessage: "No quote returned"));
    }
  } catch (e) {
    return ApiErrorHandler.handle(e);
  }
}
}