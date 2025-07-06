import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../network/api_client.dart';
import '../network/dio_provider.dart';
import '../../features/quotes/quotes.dart';
import '../../features/favorites/favorites.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Network
  Dio dio = DioProvider.getInstance();
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton(() => ApiClient(dio));

  // Repositories
  getIt.registerLazySingleton(() => QuoteRepository(getIt()));

  // Cubits
  getIt.registerFactory(() => QuoteCubit(getIt()));

  // Favorites
  getIt.registerLazySingleton<FavoritesRepository>(() => FavoritesRepository());
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit(getIt<FavoritesRepository>()));
}
