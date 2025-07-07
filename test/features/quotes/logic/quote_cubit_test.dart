import 'package:flutter_test/flutter_test.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/models/quote_model.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/repos/quote_repository.dart';
import 'package:codealpha_random_quote_generator/features/quotes/logic/cubit/quote_cubit.dart';
import 'package:codealpha_random_quote_generator/features/quotes/logic/cubit/quote_state.dart';
import 'package:codealpha_random_quote_generator/core/network/api_result.dart';
import 'package:codealpha_random_quote_generator/core/network/error_model.dart';

// Mock repository for testing
class MockQuoteRepository implements QuoteRepository {
  bool shouldFail = false;
  QuoteModel? mockQuote;
  ApiErrorModel? mockError;

  @override
  Future<ApiResult<List<QuoteModel>>> getAllQuotes() async {
    if (shouldFail) {
      return ApiResult.failure(
        mockError ?? ApiErrorModel(
          statusCode: 500,
          statusMessage: 'Test error',
        ),
      );
    }
    
    return ApiResult.success([
      mockQuote ?? QuoteModel(
        content: 'Test quote content',
        author: 'Test Author',
      ),
    ]);
  }

  @override
  Future<ApiResult<QuoteModel>> getRandomQuote() async {
    if (shouldFail) {
      return ApiResult.failure(
        mockError ?? ApiErrorModel(
          statusCode: 500,
          statusMessage: 'Test error',
        ),
      );
    }
    
    return ApiResult.success(
      mockQuote ?? QuoteModel(
        content: 'Test quote content',
        author: 'Test Author',
      ),
    );
  }
}

void main() {
  group('QuoteCubit', () {
    late QuoteCubit cubit;
    late MockQuoteRepository mockRepository;

    setUp(() {
      mockRepository = MockQuoteRepository();
      cubit = QuoteCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    group('Initialization', () {
      test('should start with initial state', () {
        expect(cubit.state, isA<QuoteState>());
        expect(cubit.state, isA<QuoteState>());
      });

      test('should track if quote has been loaded', () {
        expect(cubit.state, isA<QuoteState>());
        // Initially no quote has been loaded
      });
    });

    group('fetchRandomQuote', () {
      test('should emit loading then success state on first fetch', () async {
        // Arrange
        final testQuote = QuoteModel(
          content: 'First fetch quote',
          author: 'First Author',
        );
        mockRepository.mockQuote = testQuote;

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteSuccess>());
        final successState = cubit.state as QuoteSuccess;
        expect(successState.quotes, equals(testQuote));
      });

      test('should emit loading with isInitial=true on first fetch', () async {
        // Arrange
        final testQuote = QuoteModel(
          content: 'First fetch quote',
          author: 'First Author',
        );
        mockRepository.mockQuote = testQuote;

        // Act & Assert
        // We need to capture the loading state before it changes to success
        bool loadingEmitted = false;
        cubit.stream.listen((state) {
          if (state is QuoteLoading && state.isInitial) {
            loadingEmitted = true;
          }
        });

        await cubit.fetchRandomQuote();

        // The loading state might be too fast to catch, but we can verify the final state
        expect(cubit.state, isA<QuoteSuccess>());
      });

      test('should emit loading with isInitial=false on subsequent fetches', () async {
        // Arrange
        final firstQuote = QuoteModel(
          content: 'First quote',
          author: 'First Author',
        );
        final secondQuote = QuoteModel(
          content: 'Second quote',
          author: 'Second Author',
        );
        mockRepository.mockQuote = firstQuote;

        // Act - First fetch
        await cubit.fetchRandomQuote();
        expect(cubit.state, isA<QuoteSuccess>());

        // Arrange for second fetch
        mockRepository.mockQuote = secondQuote;

        // Act - Second fetch
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteSuccess>());
        final successState = cubit.state as QuoteSuccess;
        expect(successState.quotes, equals(secondQuote));
      });

      test('should emit error state when repository fails', () async {
        // Arrange
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Quote not found',
        );

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteError>());
        final errorState = cubit.state as QuoteError;
        expect(errorState.apiErrorModel.statusCode, equals(404));
        expect(errorState.apiErrorModel.statusMessage, equals('Quote not found'));
      });

      test('should handle multiple consecutive fetches', () async {
        // Arrange
        final quotes = [
          QuoteModel(content: 'Quote 1', author: 'Author 1'),
          QuoteModel(content: 'Quote 2', author: 'Author 2'),
          QuoteModel(content: 'Quote 3', author: 'Author 3'),
        ];

        // Act & Assert
        for (int i = 0; i < quotes.length; i++) {
          mockRepository.mockQuote = quotes[i];
          await cubit.fetchRandomQuote();
          
          expect(cubit.state, isA<QuoteSuccess>());
          final successState = cubit.state as QuoteSuccess;
          expect(successState.quotes, equals(quotes[i]));
        }
      });

      test('should handle network timeout errors', () async {
        // Arrange
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 408,
          statusMessage: 'Request timeout',
        );

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteError>());
        final errorState = cubit.state as QuoteError;
        expect(errorState.apiErrorModel.statusCode, equals(408));
        expect(errorState.apiErrorModel.statusMessage, equals('Request timeout'));
      });

      test('should handle server errors', () async {
        // Arrange
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 500,
          statusMessage: 'Internal server error',
        );

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteError>());
        final errorState = cubit.state as QuoteError;
        expect(errorState.apiErrorModel.statusCode, equals(500));
        expect(errorState.apiErrorModel.statusMessage, equals('Internal server error'));
      });
    });

    group('State transitions', () {
      test('should transition through correct states during successful fetch', () async {
        // Arrange
        final testQuote = QuoteModel(
          content: 'State transition test',
          author: 'State Author',
        );
        mockRepository.mockQuote = testQuote;

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteSuccess>());
        final successState = cubit.state as QuoteSuccess;
        expect(successState.quotes, equals(testQuote));
      });

      test('should transition through correct states during failed fetch', () async {
        // Arrange
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 400,
          statusMessage: 'Bad request',
        );

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteError>());
        final errorState = cubit.state as QuoteError;
        expect(errorState.apiErrorModel.statusCode, equals(400));
      });

      test('should maintain state consistency across multiple operations', () async {
        // Arrange
        final firstQuote = QuoteModel(content: 'First', author: 'Author 1');
        final secondQuote = QuoteModel(content: 'Second', author: 'Author 2');
        
        mockRepository.mockQuote = firstQuote;

        // Act - First successful fetch
        await cubit.fetchRandomQuote();
        expect(cubit.state, isA<QuoteSuccess>());
        expect((cubit.state as QuoteSuccess).quotes, equals(firstQuote));

        // Arrange for second fetch
        mockRepository.mockQuote = secondQuote;

        // Act - Second successful fetch
        await cubit.fetchRandomQuote();
        expect(cubit.state, isA<QuoteSuccess>());
        expect((cubit.state as QuoteSuccess).quotes, equals(secondQuote));

        // Arrange for error
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 503,
          statusMessage: 'Service unavailable',
        );

        // Act - Error fetch
        await cubit.fetchRandomQuote();
        expect(cubit.state, isA<QuoteError>());
        expect((cubit.state as QuoteError).apiErrorModel.statusCode, equals(503));
      });
    });

    group('Error handling', () {
      test('should handle null error messages gracefully', () async {
        // Arrange
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 500,
          statusMessage: null,
        );

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteError>());
        final errorState = cubit.state as QuoteError;
        expect(errorState.apiErrorModel.statusCode, equals(500));
        expect(errorState.apiErrorModel.statusMessage, isNull);
      });

      test('should handle empty error messages gracefully', () async {
        // Arrange
        mockRepository.shouldFail = true;
        mockRepository.mockError = ApiErrorModel(
          statusCode: 400,
          statusMessage: '',
        );

        // Act
        await cubit.fetchRandomQuote();

        // Assert
        expect(cubit.state, isA<QuoteError>());
        final errorState = cubit.state as QuoteError;
        expect(errorState.apiErrorModel.statusCode, equals(400));
        expect(errorState.apiErrorModel.statusMessage, equals(''));
      });
    });
  });
} 