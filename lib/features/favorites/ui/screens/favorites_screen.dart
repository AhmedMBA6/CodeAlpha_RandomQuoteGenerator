import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/favorites_cubit.dart';
import '../../logic/favorites_state.dart';
import '../../../quotes/ui/widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return state.when(
            initial: () {
              // Load favorites on first build
              context.read<FavoritesCubit>().loadFavorites();
              return const Center(child: CircularProgressIndicator());
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (favorites) {
              if (favorites.isEmpty) {
                return const Center(child: Text('No favorite quotes yet.'));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final quote = favorites[index];
                  return QuoteCard(quote: quote);
                },
              );
            },
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }
} 