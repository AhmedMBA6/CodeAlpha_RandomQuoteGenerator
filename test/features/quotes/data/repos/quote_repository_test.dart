import 'package:flutter_test/flutter_test.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/models/quote_model.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/repos/quote_repository.dart';
import 'package:codealpha_random_quote_generator/core/network/api_client.dart';
import 'package:codealpha_random_quote_generator/core/network/api_result.dart';
import 'package:codealpha_random_quote_generator/core/network/error_model.dart';

// Simple mock API client for testing
class MockApiClient implements ApiClient {
  bool shouldFail = false;
  List<QuoteModel>? mockQuotes;
  Exception? mockException;

  @override
  Future<List<QuoteModel>> getAllQuotes() async {
    if (shouldFail) {
      throw mockException ?? Exception('Test error');
    }
    return mockQuotes ?? [
      QuoteModel(content: 'Test quote', author: 'Test Author'),
    ];
  }

  @override
  Future<List<QuoteModel>> getRandomQuote() async {
    if (shouldFail) {
      throw mockException ?? Exception('Test error');
    }
    return mockQuotes ?? [
      QuoteModel(content: 'Test quote', author: 'Test Author'),
    ];
  }
}

void main() {
  group('QuoteRepository', () {
    late QuoteRepository repository;
    late MockApiClient mockApiClient;

    setUp(() {
      mockApiClient = MockApiClient();
      repository = QuoteRepository(mockApiClient);
    });

    group('getRandomQuote', () {
      test('should return success with quote when API returns non-empty list', () async {
        // Arrange
        final testQuotes = [
          QuoteModel(content: 'Test quote', author: 'Test Author'),
        ];
        mockApiClient.mockQuotes = testQuotes;

        // Act
        final result = await repository.getRandomQuote();

        // Assert
        expect(result, isA<ApiResult<QuoteModel>>());
        expect(result, isA<Success<QuoteModel>>());
        final successResult = result as Success<QuoteModel>;
        expect(successResult.data, equals(testQuotes.first));
      });

      test('should return failure when API returns empty list', () async {
        // Arrange
        mockApiClient.mockQuotes = <QuoteModel>[];

        // Act
        final result = await repository.getRandomQuote();

        // Assert
        expect(result, isA<ApiResult<QuoteModel>>());
        expect(result, isA<Failure<QuoteModel>>());
        final failureResult = result as Failure<QuoteModel>;
        expect(failureResult.apiErrorModel.statusMessage, equals('No quote returned'));
      });

      test('should return failure when API throws exception', () async {
        // Arrange
        mockApiClient.shouldFail = true;
        mockApiClient.mockException = Exception('Network error');

        // Act
        final result = await repository.getRandomQuote();

        // Assert
        expect(result, isA<ApiResult<QuoteModel>>());
        expect(result, isA<Failure<QuoteModel>>());
      });

      test('should handle multiple quotes in response and return first one', () async {
        // Arrange
        final testQuotes = [
          QuoteModel(content: 'First quote', author: 'First Author'),
          QuoteModel(content: 'Second quote', author: 'Second Author'),
          QuoteModel(content: 'Third quote', author: 'Third Author'),
        ];
        mockApiClient.mockQuotes = testQuotes;

        // Act
        final result = await repository.getRandomQuote();

        // Assert
        expect(result, isA<ApiResult<QuoteModel>>());
        expect(result, isA<Success<QuoteModel>>());
        final successResult = result as Success<QuoteModel>;
        expect(successResult.data, equals(testQuotes.first));
      });
    });

    group('getAllQuotes', () {
      test('should return success with quotes when API call succeeds', () async {
        // Arrange
        final testQuotes = [
          QuoteModel(content: 'Quote 1', author: 'Author 1'),
          QuoteModel(content: 'Quote 2', author: 'Author 2'),
          QuoteModel(content: 'Quote 3', author: 'Author 3'),
        ];
        mockApiClient.mockQuotes = testQuotes;

        // Act
        final result = await repository.getAllQuotes();

        // Assert
        expect(result, isA<ApiResult<List<QuoteModel>>>());
        expect(result, isA<Success<List<QuoteModel>>>());
        final successResult = result as Success<List<QuoteModel>>;
        expect(successResult.data, equals(testQuotes));
      });

      test('should return empty list when API returns empty list', () async {
        // Arrange
        mockApiClient.mockQuotes = <QuoteModel>[];

        // Act
        final result = await repository.getAllQuotes();

        // Assert
        expect(result, isA<ApiResult<List<QuoteModel>>>());
        expect(result, isA<Success<List<QuoteModel>>>());
        final successResult = result as Success<List<QuoteModel>>;
        expect(successResult.data, isEmpty);
      });

      test('should return failure when API throws exception', () async {
        // Arrange
        mockApiClient.shouldFail = true;
        mockApiClient.mockException = Exception('Network error');

        // Act
        final result = await repository.getAllQuotes();

        // Assert
        expect(result, isA<ApiResult<List<QuoteModel>>>());
        expect(result, isA<Failure<List<QuoteModel>>>());
      });
    });

    group('Error handling', () {
      test('should handle different types of exceptions', () async {
        // Arrange
        mockApiClient.shouldFail = true;
        mockApiClient.mockException = FormatException('Invalid data');

        // Act
        final result = await repository.getRandomQuote();

        // Assert
        expect(result, isA<ApiResult<QuoteModel>>());
        expect(result, isA<Failure<QuoteModel>>());
      });

      test('should handle timeout exceptions', () async {
        // Arrange
        mockApiClient.shouldFail = true;
        mockApiClient.mockException = Exception('Timeout');

        // Act
        final result = await repository.getRandomQuote();

        // Assert
        expect(result, isA<ApiResult<QuoteModel>>());
        expect(result, isA<Failure<QuoteModel>>());
      });
    });

    group('Concurrent operations', () {
      test('should handle multiple concurrent getRandomQuote calls', () async {
        // Arrange
        final testQuotes = [
          QuoteModel(content: 'Quote 1', author: 'Author 1'),
          QuoteModel(content: 'Quote 2', author: 'Author 2'),
        ];
        mockApiClient.mockQuotes = testQuotes;

        // Act
        final futures = [
          repository.getRandomQuote(),
          repository.getRandomQuote(),
          repository.getRandomQuote(),
        ];
        final results = await Future.wait(futures);

        // Assert
        expect(results, hasLength(3));
        for (final result in results) {
          expect(result, isA<Success<QuoteModel>>());
          final successResult = result as Success<QuoteModel>;
          expect(successResult.data, equals(testQuotes.first));
        }
      });

      test('should handle concurrent getAllQuotes and getRandomQuote calls', () async {
        // Arrange
        final allQuotes = [
          QuoteModel(content: 'All Quote 1', author: 'All Author 1'),
          QuoteModel(content: 'All Quote 2', author: 'All Author 2'),
        ];
        final randomQuotes = [
          QuoteModel(content: 'Random Quote', author: 'Random Author'),
        ];

        // We need to set up the mock to return different values for different calls
        // This is a simplified test - in a real scenario you'd use a more sophisticated mock
        mockApiClient.mockQuotes = allQuotes;

        // Act
        final allQuotesResult = repository.getAllQuotes();
        final randomQuoteResult = repository.getRandomQuote();

        final results = await Future.wait([allQuotesResult, randomQuoteResult]);

        // Assert
        expect(results[0], isA<Success<List<QuoteModel>>>());
        expect((results[0] as Success<List<QuoteModel>>).data, equals(allQuotes));
        expect(results[1], isA<Success<QuoteModel>>());
        expect((results[1] as Success<QuoteModel>).data, equals(allQuotes.first));
      });
    });
  });
} 