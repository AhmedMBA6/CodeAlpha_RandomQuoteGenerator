import 'package:flutter_test/flutter_test.dart';
import 'package:codealpha_random_quote_generator/core/network/api_result.dart';
import 'package:codealpha_random_quote_generator/core/network/error_model.dart';

void main() {
  group('ApiResult', () {
    group('Success', () {
      test('should create success result with data', () {
        // Arrange
        const testData = 'test data';

        // Act
        final result = ApiResult.success(testData);

        // Assert
        expect(result, isA<ApiResult<String>>());
        expect(result, isA<Success<String>>());
        final successResult = result as Success<String>;
        expect(successResult.data, equals(testData));
      });

      test('should handle complex data types', () {
        // Arrange
        final testData = {'key': 'value', 'number': 42};

        // Act
        final result = ApiResult.success(testData);

        // Assert
        expect(result, isA<ApiResult<Map<String, dynamic>>>());
        expect(result, isA<Success<Map<String, dynamic>>>());
        final successResult = result as Success<Map<String, dynamic>>;
        expect(successResult.data, equals(testData));
        expect(successResult.data['key'], equals('value'));
        expect(successResult.data['number'], equals(42));
      });

      test('should handle null data', () {
        // Act
        final result = ApiResult.success(null);

        // Assert
        expect(result, isA<ApiResult<Object?>>());
        expect(result, isA<Success<Object?>>());
        final successResult = result as Success<Object?>;
        expect(successResult.data, isNull);
      });

      test('should handle empty collections', () {
        // Arrange
        final emptyList = <String>[];

        // Act
        final result = ApiResult.success(emptyList);

        // Assert
        expect(result, isA<ApiResult<List<String>>>());
        expect(result, isA<Success<List<String>>>());
        final successResult = result as Success<List<String>>;
        expect(successResult.data, isEmpty);
      });
    });

    group('Failure', () {
      test('should create failure result with error model', () {
        // Arrange
        final errorModel = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act
        final result = ApiResult.failure(errorModel);

        // Assert
        expect(result, isA<ApiResult<dynamic>>());
        expect(result, isA<Failure<dynamic>>());
        final failureResult = result as Failure<dynamic>;
        expect(failureResult.apiErrorModel, equals(errorModel));
        expect(failureResult.apiErrorModel.statusCode, equals(404));
        expect(failureResult.apiErrorModel.statusMessage, equals('Not found'));
      });

      test('should handle error model with null values', () {
        // Arrange
        final errorModel = ApiErrorModel(
          statusCode: null,
          statusMessage: null,
        );

        // Act
        final result = ApiResult.failure(errorModel);

        // Assert
        expect(result, isA<ApiResult<dynamic>>());
        expect(result, isA<Failure<dynamic>>());
        final failureResult = result as Failure<dynamic>;
        expect(failureResult.apiErrorModel.statusCode, isNull);
        expect(failureResult.apiErrorModel.statusMessage, isNull);
      });

      test('should handle error model with empty message', () {
        // Arrange
        final errorModel = ApiErrorModel(
          statusCode: 500,
          statusMessage: '',
        );

        // Act
        final result = ApiResult.failure(errorModel);

        // Assert
        expect(result, isA<ApiResult<dynamic>>());
        expect(result, isA<Failure<dynamic>>());
        final failureResult = result as Failure<dynamic>;
        expect(failureResult.apiErrorModel.statusCode, equals(500));
        expect(failureResult.apiErrorModel.statusMessage, equals(''));
      });

      test('should handle different error status codes', () {
        // Test various HTTP status codes
        final statusCodes = [400, 401, 403, 404, 500, 502, 503];
        
        for (final statusCode in statusCodes) {
          // Arrange
          final errorModel = ApiErrorModel(
            statusCode: statusCode,
            statusMessage: 'Error $statusCode',
          );

          // Act
          final result = ApiResult.failure(errorModel);

          // Assert
          expect(result, isA<Failure<dynamic>>());
          final failureResult = result as Failure<dynamic>;
          expect(failureResult.apiErrorModel.statusCode, equals(statusCode));
          expect(failureResult.apiErrorModel.statusMessage, equals('Error $statusCode'));
        }
      });
    });

    group('Equality and hashCode', () {
      test('should be equal when success data is the same', () {
        // Arrange
        const data = 'test data';
        final result1 = ApiResult.success(data);
        final result2 = ApiResult.success(data);

        // Act & Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('should not be equal when success data is different', () {
        // Arrange
        final result1 = ApiResult.success('data1');
        final result2 = ApiResult.success('data2');

        // Act & Assert
        expect(result1, isNot(equals(result2)));
        expect(result1.hashCode, isNot(equals(result2.hashCode)));
      });

      test('should be equal when failure error models are the same', () {
        // Arrange
        final errorModel = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final result1 = ApiResult.failure(errorModel);
        final result2 = ApiResult.failure(errorModel);

        // Act & Assert
        expect(result1, equals(result2));
        expect(result1.hashCode, equals(result2.hashCode));
      });

      test('should not be equal when failure error models are different', () {
        // Arrange
        final errorModel1 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final errorModel2 = ApiErrorModel(
          statusCode: 500,
          statusMessage: 'Server error',
        );
        final result1 = ApiResult.failure(errorModel1);
        final result2 = ApiResult.failure(errorModel2);

        // Act & Assert
        expect(result1, isNot(equals(result2)));
        expect(result1.hashCode, isNot(equals(result2.hashCode)));
      });

      test('should not be equal when one is success and other is failure', () {
        // Arrange
        final successResult = ApiResult.success('data');
        final errorModel = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final failureResult = ApiResult.failure(errorModel);

        // Act & Assert
        expect(successResult, isNot(equals(failureResult)));
        expect(successResult.hashCode, isNot(equals(failureResult.hashCode)));
      });

      test('should be equal to itself', () {
        // Arrange
        final result = ApiResult.success('test');

        // Act & Assert
        expect(result, equals(result));
      });

      test('should not be equal to null', () {
        // Arrange
        final result = ApiResult.success('test');

        // Act & Assert
        expect(result, isNot(equals(null)));
      });

      test('should not be equal to different type', () {
        // Arrange
        final result = ApiResult.success('test');

        // Act & Assert
        expect(result, isNot(equals('string')));
        expect(result, isNot(equals(123)));
        expect(result, isNot(equals({})));
      });
    });

    group('toString', () {
      test('should return meaningful string representation for success', () {
        // Arrange
        final result = ApiResult.success('test data');

        // Act
        final stringRepresentation = result.toString();

        // Assert
        expect(stringRepresentation, contains('ApiResult'));
        expect(stringRepresentation, contains('success'));
        expect(stringRepresentation, contains('test data'));
      });

      test('should return meaningful string representation for failure', () {
        // Arrange
        final errorModel = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final result = ApiResult.failure(errorModel);

        // Act
        final stringRepresentation = result.toString();

        // Assert
        expect(stringRepresentation, contains('ApiResult'));
        expect(stringRepresentation, contains('failure'));
        expect(stringRepresentation, contains('ApiErrorModel'));
      });
    });

    group('Type safety', () {
      test('should maintain type safety for different data types', () {
        // Arrange
        final stringResult = ApiResult.success('string data');
        final intResult = ApiResult.success(42);
        final boolResult = ApiResult.success(true);
        final listResult = ApiResult.success([1, 2, 3]);

        // Act & Assert
        expect(stringResult, isA<ApiResult<String>>());
        expect(intResult, isA<ApiResult<int>>());
        expect(boolResult, isA<ApiResult<bool>>());
        expect(listResult, isA<ApiResult<List<int>>>());

        expect(stringResult, isA<Success<String>>());
        expect(intResult, isA<Success<int>>());
        expect(boolResult, isA<Success<bool>>());
        expect(listResult, isA<Success<List<int>>>());
      });

      test('should handle generic types correctly', () {
        // Arrange
        final mapResult = ApiResult.success(<String, dynamic>{
          'key': 'value',
          'number': 42,
        });

        // Act & Assert
        expect(mapResult, isA<ApiResult<Map<String, dynamic>>>());
        expect(mapResult, isA<Success<Map<String, dynamic>>>());
        
        final successResult = mapResult as Success<Map<String, dynamic>>;
        expect(successResult.data['key'], equals('value'));
        expect(successResult.data['number'], equals(42));
      });
    });
  });
} 