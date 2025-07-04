import 'package:codealpha_random_quote_generator/features/quotes/data/models/quote_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'api_constants.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

   /// Get a random quote (GET)
  @GET(ApiConstants.getRandomQuote)
  Future<List<QuoteModel>> getRandomQuote();

  /// Get all quotes (GET)
  @GET(ApiConstants.getAllQuotes)
  Future<List<QuoteModel>> getAllQuotes();
} 