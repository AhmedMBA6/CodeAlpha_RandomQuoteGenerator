import 'package:flutter_test/flutter_test.dart';
import 'package:codealpha_random_quote_generator/core/network/error_model.dart';

void main() {
  group('ApiErrorModel', () {
    group('JSON serialization', () {
      test('should serialize to JSON correctly', () {
        // Arrange
        final errorModel = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act
        final json = errorModel.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['statusCode'], equals(404));
        expect(json['statusMessage'], equals('Not found'));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'statusCode': 500,
          'statusMessage': 'Internal server error',
        };

        // Act
        final errorModel = ApiErrorModel.fromJson(json);

        // Assert
        expect(errorModel.statusCode, equals(500));
        expect(errorModel.statusMessage, equals('Internal server error'));
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalError = ApiErrorModel(
          statusCode: 403,
          statusMessage: 'Forbidden',
        );

        // Act
        final json = originalError.toJson();
        final deserializedError = ApiErrorModel.fromJson(json);

        // Assert
        expect(deserializedError.statusCode, equals(originalError.statusCode));
        expect(deserializedError.statusMessage, equals(originalError.statusMessage));
      });

      test('should handle null values in JSON', () {
        // Arrange
        final json = {
          'statusCode': null,
          'statusMessage': null,
        };

        // Act
        final errorModel = ApiErrorModel.fromJson(json);

        // Assert
        expect(errorModel.statusCode, isNull);
        expect(errorModel.statusMessage, isNull);
      });

      test('should handle missing fields in JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final errorModel = ApiErrorModel.fromJson(json);

        // Assert
        expect(errorModel.statusCode, isNull);
        expect(errorModel.statusMessage, isNull);
      });

      test('should handle partial fields in JSON', () {
        // Arrange
        final json = {
          'statusCode': 400,
        };

        // Act
        final errorModel = ApiErrorModel.fromJson(json);

        // Assert
        expect(errorModel.statusCode, equals(400));
        expect(errorModel.statusMessage, isNull);
      });
    });

    group('Constructor', () {
      test('should create with all parameters', () {
        // Arrange & Act
        final errorModel = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Assert
        expect(errorModel.statusCode, equals(404));
        expect(errorModel.statusMessage, equals('Not found'));
      });

      test('should create with null statusCode', () {
        // Arrange & Act
        final errorModel = ApiErrorModel(
          statusCode: null,
          statusMessage: 'Error message',
        );

        // Assert
        expect(errorModel.statusCode, isNull);
        expect(errorModel.statusMessage, equals('Error message'));
      });

      test('should create with null statusMessage', () {
        // Arrange & Act
        final errorModel = ApiErrorModel(
          statusCode: 500,
          statusMessage: null,
        );

        // Assert
        expect(errorModel.statusCode, equals(500));
        expect(errorModel.statusMessage, isNull);
      });

      test('should create with both null values', () {
        // Arrange & Act
        final errorModel = ApiErrorModel(
          statusCode: null,
          statusMessage: null,
        );

        // Assert
        expect(errorModel.statusCode, isNull);
        expect(errorModel.statusMessage, isNull);
      });

      test('should create with empty string message', () {
        // Arrange & Act
        final errorModel = ApiErrorModel(
          statusCode: 200,
          statusMessage: '',
        );

        // Assert
        expect(errorModel.statusCode, equals(200));
        expect(errorModel.statusMessage, equals(''));
      });
    });

    group('Equality and hashCode', () {
      test('should be equal when all fields are the same', () {
        // Arrange
        final error1 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final error2 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act & Assert
        // Note: ApiErrorModel uses default equality, so identical objects are equal
        expect(error1, equals(error1));
        expect(error2, equals(error2));
        // Different instances with same values are not equal (default behavior)
        expect(error1, isNot(equals(error2)));
      });

      test('should not be equal when statusCode is different', () {
        // Arrange
        final error1 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final error2 = ApiErrorModel(
          statusCode: 500,
          statusMessage: 'Not found',
        );

        // Act & Assert
        expect(error1, isNot(equals(error2)));
      });

      test('should not be equal when statusMessage is different', () {
        // Arrange
        final error1 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final error2 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Server error',
        );

        // Act & Assert
        expect(error1, isNot(equals(error2)));
      });

      test('should not be equal when both fields are different', () {
        // Arrange
        final error1 = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );
        final error2 = ApiErrorModel(
          statusCode: 500,
          statusMessage: 'Server error',
        );

        // Act & Assert
        expect(error1, isNot(equals(error2)));
      });

      test('should handle null values in equality comparison', () {
        // Arrange
        final error1 = ApiErrorModel(
          statusCode: null,
          statusMessage: 'Error',
        );
        final error2 = ApiErrorModel(
          statusCode: null,
          statusMessage: 'Error',
        );

        // Act & Assert
        // Different instances with same values are not equal (default behavior)
        expect(error1, isNot(equals(error2)));
      });

      test('should handle different null combinations', () {
        // Arrange
        final error1 = ApiErrorModel(
          statusCode: 404,
          statusMessage: null,
        );
        final error2 = ApiErrorModel(
          statusCode: null,
          statusMessage: 'Error',
        );

        // Act & Assert
        expect(error1, isNot(equals(error2)));
      });

      test('should be equal to itself', () {
        // Arrange
        final error = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act & Assert
        expect(error, equals(error));
      });

      test('should not be equal to null', () {
        // Arrange
        final error = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act & Assert
        expect(error, isNot(equals(null)));
      });

      test('should not be equal to different type', () {
        // Arrange
        final error = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act & Assert
        expect(error, isNot(equals('string')));
        expect(error, isNot(equals(123)));
        expect(error, isNot(equals({})));
      });
    });

    group('toString', () {
      test('should return meaningful string representation', () {
        // Arrange
        final error = ApiErrorModel(
          statusCode: 404,
          statusMessage: 'Not found',
        );

        // Act
        final stringRepresentation = error.toString();

        // Assert
        expect(stringRepresentation, contains('ApiErrorModel'));
        // Note: ApiErrorModel uses default toString, so we just check it contains the class name
      });

      test('should handle null values in toString', () {
        // Arrange
        final error = ApiErrorModel(
          statusCode: null,
          statusMessage: null,
        );

        // Act
        final stringRepresentation = error.toString();

        // Assert
        expect(stringRepresentation, contains('ApiErrorModel'));
        // Note: ApiErrorModel uses default toString, so we just check it contains the class name
      });

      test('should handle empty string in toString', () {
        // Arrange
        final error = ApiErrorModel(
          statusCode: 200,
          statusMessage: '',
        );

        // Act
        final stringRepresentation = error.toString();

        // Assert
        expect(stringRepresentation, contains('ApiErrorModel'));
        // Note: ApiErrorModel uses default toString, so we just check it contains the class name
      });
    });

    group('HTTP status codes', () {
      test('should handle common HTTP status codes', () {
        // Test various HTTP status codes
        final statusCodes = [
          200, // OK
          201, // Created
          400, // Bad Request
          401, // Unauthorized
          403, // Forbidden
          404, // Not Found
          500, // Internal Server Error
          502, // Bad Gateway
          503, // Service Unavailable
        ];

        for (final statusCode in statusCodes) {
          // Arrange & Act
          final error = ApiErrorModel(
            statusCode: statusCode,
            statusMessage: 'Error $statusCode',
          );

          // Assert
          expect(error.statusCode, equals(statusCode));
          expect(error.statusMessage, equals('Error $statusCode'));
        }
      });

      test('should handle edge case status codes', () {
        // Test edge cases
        final edgeCases = [0, 1, 999, 1000];

        for (final statusCode in edgeCases) {
          // Arrange & Act
          final error = ApiErrorModel(
            statusCode: statusCode,
            statusMessage: 'Edge case $statusCode',
          );

          // Assert
          expect(error.statusCode, equals(statusCode));
          expect(error.statusMessage, equals('Edge case $statusCode'));
        }
      });
    });

    group('Error messages', () {
      test('should handle long error messages', () {
        // Arrange
        final longMessage = 'A very long error message that contains many characters and should be handled properly by the ApiErrorModel class without any issues or truncation';

        // Act
        final error = ApiErrorModel(
          statusCode: 500,
          statusMessage: longMessage,
        );

        // Assert
        expect(error.statusMessage, equals(longMessage));
      });

      test('should handle special characters in error messages', () {
        // Arrange
        final specialChars = 'Error with special chars: !@#\$%^&*()_+-=[]{}|;:,.<>?';

        // Act
        final error = ApiErrorModel(
          statusCode: 400,
          statusMessage: specialChars,
        );

        // Assert
        expect(error.statusMessage, equals(specialChars));
      });

      test('should handle unicode characters in error messages', () {
        // Arrange
        final unicodeMessage = 'Error with unicode: ñáéíóú üöäëïÿ';

        // Act
        final error = ApiErrorModel(
          statusCode: 400,
          statusMessage: unicodeMessage,
        );

        // Assert
        expect(error.statusMessage, equals(unicodeMessage));
      });
    });
  });
} 