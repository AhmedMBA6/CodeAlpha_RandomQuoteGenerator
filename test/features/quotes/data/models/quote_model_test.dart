import 'package:flutter_test/flutter_test.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/models/quote_model.dart';

void main() {
  group('QuoteModel', () {
    group('JSON serialization', () {
      test('should serialize to JSON correctly', () {
        // Arrange
        final quote = QuoteModel(
          content: 'Test quote content',
          author: 'Test Author',
        );

        // Act
        final json = quote.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['q'], equals('Test quote content'));
        expect(json['a'], equals('Test Author'));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'q': 'Test quote content',
          'a': 'Test Author',
        };

        // Act
        final quote = QuoteModel.fromJson(json);

        // Assert
        expect(quote.content, equals('Test quote content'));
        expect(quote.author, equals('Test Author'));
      });

      test('should handle round-trip serialization', () {
        // Arrange
        final originalQuote = QuoteModel(
          content: 'Round trip test quote',
          author: 'Round Trip Author',
        );

        // Act
        final json = originalQuote.toJson();
        final deserializedQuote = QuoteModel.fromJson(json);

        // Assert
        expect(deserializedQuote, equals(originalQuote));
        expect(deserializedQuote.content, equals(originalQuote.content));
        expect(deserializedQuote.author, equals(originalQuote.author));
      });
    });

    group('Equality and hashCode', () {
      test('should be equal when content and author are the same', () {
        // Arrange
        final quote1 = QuoteModel(
          content: 'Same content',
          author: 'Same author',
        );
        final quote2 = QuoteModel(
          content: 'Same content',
          author: 'Same author',
        );

        // Act & Assert
        expect(quote1, equals(quote2));
        expect(quote1.hashCode, equals(quote2.hashCode));
      });

      test('should not be equal when content is different', () {
        // Arrange
        final quote1 = QuoteModel(
          content: 'Different content',
          author: 'Same author',
        );
        final quote2 = QuoteModel(
          content: 'Same content',
          author: 'Same author',
        );

        // Act & Assert
        expect(quote1, isNot(equals(quote2)));
        expect(quote1.hashCode, isNot(equals(quote2.hashCode)));
      });

      test('should not be equal when author is different', () {
        // Arrange
        final quote1 = QuoteModel(
          content: 'Same content',
          author: 'Different author',
        );
        final quote2 = QuoteModel(
          content: 'Same content',
          author: 'Same author',
        );

        // Act & Assert
        expect(quote1, isNot(equals(quote2)));
        expect(quote1.hashCode, isNot(equals(quote2.hashCode)));
      });

      test('should not be equal when both content and author are different', () {
        // Arrange
        final quote1 = QuoteModel(
          content: 'Different content',
          author: 'Different author',
        );
        final quote2 = QuoteModel(
          content: 'Same content',
          author: 'Same author',
        );

        // Act & Assert
        expect(quote1, isNot(equals(quote2)));
        expect(quote1.hashCode, isNot(equals(quote2.hashCode)));
      });

      test('should be equal to itself', () {
        // Arrange
        final quote = QuoteModel(
          content: 'Self test quote',
          author: 'Self Author',
        );

        // Act & Assert
        expect(quote, equals(quote));
      });

      test('should not be equal to null', () {
        // Arrange
        final quote = QuoteModel(
          content: 'Null test quote',
          author: 'Null Author',
        );

        // Act & Assert
        expect(quote, isNot(equals(null)));
      });

      test('should not be equal to different type', () {
        // Arrange
        final quote = QuoteModel(
          content: 'Type test quote',
          author: 'Type Author',
        );

        // Act & Assert
        expect(quote, isNot(equals('string')));
        expect(quote, isNot(equals(123)));
        expect(quote, isNot(equals({})));
      });
    });

    group('toString', () {
      test('should return meaningful string representation', () {
        // Arrange
        final quote = QuoteModel(
          content: 'ToString test quote',
          author: 'ToString Author',
        );

        // Act
        final stringRepresentation = quote.toString();

        // Assert
        expect(stringRepresentation, contains('QuoteModel'));
        // Note: QuoteModel uses default toString, so we just check it contains the class name
      });
    });
  });
} 