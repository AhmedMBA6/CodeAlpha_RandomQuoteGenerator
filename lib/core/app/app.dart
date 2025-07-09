import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/app_config.dart';
import '../di/injection_container.dart' as di;
import '../../features/quotes/quotes.dart';
import '../../features/favorites/favorites.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.getIt<QuoteCubit>()),
        BlocProvider(create: (context) => di.getIt<FavoritesCubit>()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: AppConfig.lightTheme,
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const QuoteScreen(),
          Routes.favorites: (context) => const FavoritesScreen(),
        },
      ),
    );
  }
} 