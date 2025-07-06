import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../config/app_config.dart';
import '../di/injection_container.dart' as di;
import '../../features/quotes/logic/cubit/quote_cubit.dart';
import '../../features/quotes/ui/screens/quote_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: AppConfig.lightTheme,
      home: BlocProvider(
        create: (context) => di.getIt<QuoteCubit>(),
        child: const QuoteScreen(),
      ),
    );
  }
} 