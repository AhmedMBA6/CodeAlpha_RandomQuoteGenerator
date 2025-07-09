import 'package:flutter_test/flutter_test.dart';
import 'package:codealpha_random_quote_generator/features/quotes/data/models/quote_model.dart';
import 'package:codealpha_random_quote_generator/features/favorites/data/favorites_repository.dart';
import 'package:codealpha_random_quote_generator/core/utils/shared_prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  
  group('FavoritesRepository', () {
    late FavoritesRepository repository;
    late SharedPrefsService prefsService;

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      prefsService = SharedPrefsService(prefs);
      repository = FavoritesRepository(prefsService);
    });

    group('QuoteModel equality', () {
      test('should correctly identify equal quotes', () {
        // Arrange
        final quote1 = QuoteModel(content: 'Test quote', author: 'Test author');
        final quote2 = QuoteModel(content: 'Test quote', author: 'Test author');

        // Act & Assert
        expect(quote1, equals(quote2));
        expect(quote1.hashCode, equals(quote2.hashCode));
      });

      test('should correctly identify different quotes', () {
        // Arrange
        final quote1 = QuoteModel(content: 'Test quote 1', author: 'Test author');
        final quote2 = QuoteModel(content: 'Test quote 2', author: 'Test author');

        // Act & Assert
        expect(quote1, isNot(equals(quote2)));
      });
    });

    group('JSON serialization', () {
      test('should serialize and deserialize quote correctly', () {
        // Arrange
        final quote = QuoteModel(content: 'Test quote', author: 'Test author');

        // Act
        final json = quote.toJson();
        final deserializedQuote = QuoteModel.fromJson(json);

        // Assert
        expect(deserializedQuote.content, equals(quote.content));
        expect(deserializedQuote.author, equals(quote.author));
        expect(deserializedQuote, equals(quote));
      });
    });

    group('Repository operations', () {
      test('should handle empty favorites list', () async {
        // Act
        final favorites = await repository.getFavorites();

        // Assert
        expect(favorites, isEmpty);
      });

      test('should add and retrieve favorite', () async {
        // Arrange
        final quote = QuoteModel(content: 'Test quote', author: 'Test author');

        // Act
        await repository.addFavorite(quote);
        final favorites = await repository.getFavorites();
        final isFavorite = await repository.isFavorite(quote);

        // Assert
        expect(favorites, hasLength(1));
        expect(favorites.first, equals(quote));
        expect(isFavorite, isTrue);
      });

      test('should not add duplicate favorites', () async {
        // Arrange
        final quote = QuoteModel(content: 'Test quote', author: 'Test author');

        // Act
        await repository.addFavorite(quote);
        await repository.addFavorite(quote); // Try to add same quote again
        final favorites = await repository.getFavorites();

        // Assert
        expect(favorites, hasLength(1));
        expect(favorites.first, equals(quote));
      });

      test('should remove favorite', () async {
        // Arrange
        final quote = QuoteModel(content: 'Test quote', author: 'Test author');
        await repository.addFavorite(quote);

        // Act
        await repository.removeFavorite(quote);
        final favorites = await repository.getFavorites();
        final isFavorite = await repository.isFavorite(quote);

        // Assert
        expect(favorites, isEmpty);
        expect(isFavorite, isFalse);
      });

      test('should handle removing non-existent favorite gracefully', () async {
        // Arrange
        final quote = QuoteModel(content: 'Non-existent quote', author: 'Test author');

        // Act
        await repository.removeFavorite(quote);
        final favorites = await repository.getFavorites();

        // Assert
        expect(favorites, isEmpty);
      });

      test('should manage multiple favorites correctly', () async {
        // Arrange
        final quote1 = QuoteModel(content: 'Quote 1', author: 'Author 1');
        final quote2 = QuoteModel(content: 'Quote 2', author: 'Author 2');
        final quote3 = QuoteModel(content: 'Quote 3', author: 'Author 3');

        // Act
        await repository.addFavorite(quote1);
        await repository.addFavorite(quote2);
        await repository.addFavorite(quote3);
        
        final favorites = await repository.getFavorites();
        final isFavorite1 = await repository.isFavorite(quote1);
        final isFavorite2 = await repository.isFavorite(quote2);
        final isFavorite3 = await repository.isFavorite(quote3);

        // Assert
        expect(favorites, hasLength(3));
        expect(isFavorite1, isTrue);
        expect(isFavorite2, isTrue);
        expect(isFavorite3, isTrue);

        // Remove one favorite
        await repository.removeFavorite(quote2);
        final updatedFavorites = await repository.getFavorites();
        final isFavorite2AfterRemoval = await repository.isFavorite(quote2);

        expect(updatedFavorites, hasLength(2));
        expect(isFavorite2AfterRemoval, isFalse);
        expect(updatedFavorites.contains(quote1), isTrue);
        expect(updatedFavorites.contains(quote3), isTrue);
      });
    });
  });
} 