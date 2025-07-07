/// QuoteCard displays a single quote with author, favorite button, and animated effects.
/// Used in the main quote screen and favorites list.
library;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorites/favorites.dart';
import '../../data/models/quote_model.dart';
import 'package:codealpha_random_quote_generator/core/config/ui_constants.dart';

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
  late final AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    // Card entrance animation
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    // Content transition animation
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _cardController.forward();
  }

  @override
  void didUpdateWidget(covariant QuoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quote.content != widget.quote.content) {
      // Trigger content transition animation
      _contentController.forward(from: 0);
      // Slight delay for card animation to feel more natural
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _cardController.forward(from: 0);
        }
      });
    }
  }

  @override
  void dispose() {
    _cardController.dispose();
    _boltController.dispose();
    _favController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive width for the card (max 500, min 280)
        final cardWidth = constraints.maxWidth.clamp(280.0, 500.0);
        final horizontalPadding = cardWidth * 0.08;
        final verticalPadding = cardWidth * 0.08;
        final iconSize = cardWidth * 0.13; // e.g. 54 at 400px
        final boltShadowBlur = cardWidth * 0.08;
        final contentFontSize = (cardWidth * 0.07).clamp(16.0, 28.0);
        final authorFontSize = (cardWidth * 0.05).clamp(12.0, 20.0);
        final favIconSize = cardWidth * 0.08;
        final spacing1 = cardWidth * 0.06; // e.g. 24 at 400px
        final spacing2 = cardWidth * 0.08; // e.g. 32 at 400px

        return FadeTransition(
          opacity: _cardController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.08),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: _cardController, curve: Curves.easeOutCubic)),
            child: Center(
              child: SizedBox(
                width: cardWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(kCardBorderRadius),
                  child: Stack(
                    children: [
                      // Glassmorphism effect for card background
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(kGlassOpacity),
                            borderRadius: BorderRadius.circular(kCardBorderRadius),
                            border: Border.all(
                              color: theme.colorScheme.primary.withAlpha((kPrimaryShadowOpacity * 255).round()),
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withAlpha((kPrimaryShadowOpacity * 255).round()),
                                blurRadius: 32,
                                spreadRadius: 2,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: verticalPadding,
                            ),
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
                                              blurRadius: boltShadowBlur,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.flash_on,
                                          size: iconSize,
                                          color: theme.colorScheme.secondary,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: spacing1),
                                // Quote content with AnimatedSwitcher for smooth transitions
                                AnimatedSwitcher(
                                  duration: kContentTransitionDuration,
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0, 0.1),
                                          end: Offset.zero,
                                        ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOutCubic,
                                        )),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    widget.quote.content,
                                    key: ValueKey(widget.quote.content),
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 1.5,
                                      fontSize: contentFontSize,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: spacing2),
                                // Author with AnimatedSwitcher
                                AnimatedSwitcher(
                                  duration: kContentTransitionDuration,
                                  transitionBuilder: (Widget child, Animation<double> animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0, 0.1),
                                          end: Offset.zero,
                                        ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeOutCubic,
                                        )),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    key: ValueKey('${widget.quote.author}-${widget.quote.content}'),
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Author
                                      Text(
                                        '- ${widget.quote.author}',
                                        style: theme.textTheme.bodyMedium?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: authorFontSize,
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
                                                    duration: kContentTransitionDuration,
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
                                                  color: isFavorite ? kFavoriteColor : kFavoriteColor.withAlpha((0.4 * 255).round()),
                                                  size: favIconSize,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
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
            ),
          ),
        );
      },
    );
  }
} 