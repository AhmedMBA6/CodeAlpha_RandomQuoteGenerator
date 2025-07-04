import 'package:codealpha_random_quote_generator/core/network/error_model.dart';
import 'package:dio/dio.dart';

import 'api_result.dart';

class ApiErrorHandler {
  /// Public method to wrap any error into ApiResult.failure
  static ApiResult<T> handle<T>(dynamic error) {
    final errorModel = _extractError(error);
    return ApiResult.failure(errorModel);
  }

  /// Internal helper that turns DioException or any error into ErrorModel
  static ApiErrorModel _extractError(dynamic error) {
    if (error is DioException) {
      final response = error.response;

      // ZenQuotes returns list of error quote
      if (response?.data is List) {
        final data = response!.data;
        if (data.isNotEmpty && data.first is Map<String, dynamic>) {
          final q = data.first['q'] ?? '';
          if (q.toString().toLowerCase().contains('unrecognized')) {
            return ApiErrorModel(statusMessage: q, statusCode: 404);
          }
        }
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            statusMessage: 'Connection timed out',
            statusCode: 408,
          );
        case DioExceptionType.cancel:
          return ApiErrorModel(statusMessage: 'Request cancelled');
        case DioExceptionType.connectionError:
          return ApiErrorModel(statusMessage: 'Connection error');
        case DioExceptionType.badResponse:
          return ApiErrorModel(
            statusMessage: response?.statusMessage ?? 'Bad server response',
            statusCode: response?.statusCode ?? 500,
          );
        case DioExceptionType.unknown:
        default:
          return ApiErrorModel(
            statusMessage: error.message ?? 'Unexpected error occurred',
            statusCode: response?.statusCode ?? 520,
          );
      }
    }

    return ApiErrorModel(
      statusMessage: 'Unknown application error',
      statusCode: 500,
    );
  }
}
