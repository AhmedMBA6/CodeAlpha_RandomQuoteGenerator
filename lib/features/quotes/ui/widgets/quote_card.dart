/// QuoteCard displays a single quote with author, favorite button, and animated effects.
/// Used in the main quote screen and favorites list.
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/favorites.dart';
import '../../data/models/quote_model.dart';

/// A card widget that displays a quote, author, and favorite button with animation.
class QuoteCard extends StatefulWidget {
  final QuoteModel quote;
  const QuoteCard({super.key, required this.quote});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> with TickerProviderStateMixin {
  late final AnimationController _cardController;
  late final AnimationController _boltController;
  late final AnimationController _favController;

  @override
  void initState() {
    super.initState();
    // Card entrance animation
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    // Lightning bolt pulse animation
    _boltController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    // Favorite icon scale animation
    _favController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 1.0,
      upperBound: 1.3,
    );
    _cardController.forward();
  }

  @override
  void didUpdateWidget(covariant QuoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quote.content != widget.quote.content) {
      _cardController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _cardController.dispose();
    _boltController.dispose();
    _favController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FadeTransition(
      opacity: _cardController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOut)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Glassmorphism effect for card background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    // Use withOpacity for glassy effect
                    color: Colors.white.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: theme.colorScheme.primary.withAlpha((0.18 * 255).round()),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withAlpha((0.18 * 255).round()),
                        blurRadius: 32,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated lightning bolt icon
                        AnimatedBuilder(
                          animation: _boltController,
                          builder: (context, child) {
                            double scale = 1 + 0.08 * _boltController.value;
                            double glow = 0.3 + 0.7 * _boltController.value;
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.secondary.withAlpha((glow * 255).round()),
                                      blurRadius: 32,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.flash_on,
                                  size: 54,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        // Quote content
                        Text(
                          '“${widget.quote.content}”',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Author
                            Text(
                              '- ${widget.quote.author}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            // Favorite button with animation and accessibility
                            BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, state) {
                                final favorites = state.maybeWhen(
                                  success: (favorites) => favorites,
                                  orElse: () => <QuoteModel>[],
                                );
                                final isFavorite = favorites.any((q) => q == widget.quote);
                                return GestureDetector(
                                  onTap: () async {
                                    final cubit = context.read<FavoritesCubit>();
                                    String message;
                                    if (isFavorite) {
                                      await cubit.removeFavorite(widget.quote);
                                      message = 'Removed from favorites.';
                                    } else {
                                      await cubit.addFavorite(widget.quote);
                                      message = 'Added to favorites!';
                                    }
                                    await _favController.forward(from: 0);
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                          duration: const Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  },
                                  child: Semantics(
                                    label: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                                    button: true,
                                    child: ScaleTransition(
                                      scale: _favController,
                                      child: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.amber
                                            : Colors.amber.withAlpha((0.4 * 255).round()),
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 