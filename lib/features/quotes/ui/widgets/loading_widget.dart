/// LoadingWidget displays a shimmer effect for loading states in the quote app.
/// Uses withOpacity for backgrounds to achieve a subtle, glassy effect.
/// This is visually preferable for shimmer, even if withOpacity is deprecated elsewhere.
library;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:codealpha_random_quote_generator/core/config/ui_constants.dart';

/// A widget that displays a shimmer loading placeholder for quotes and buttons.
class LoadingWidget extends StatefulWidget {
  final bool showButtonShimmer;
  const LoadingWidget({super.key, this.showButtonShimmer = true});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Entrance animation for shimmer
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth < 400 ? constraints.maxWidth : 400.0;
        final padding = MediaQuery.of(context).size.width * 0.06;
        return Center(
          child: Padding(
            padding: EdgeInsets.all(padding.clamp(16, 32)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _controller,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.08),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
                    child: Semantics(
                      label: 'Loading quotes',
                      container: true,
                      child: _buildShimmerCard(context, width),
                    ),
                  ),
                ),
                if (widget.showButtonShimmer) ...[
                  SizedBox(height: (MediaQuery.of(context).size.height * 0.04).clamp(24, 40)),
                  Shimmer.fromColors(
                    baseColor: theme.colorScheme.secondary.withOpacity(0.12),
                    highlightColor: theme.colorScheme.primary.withOpacity(0.18),
                    child: Container(
                      width: width * 0.7,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(kGlassOpacity),
                        borderRadius: BorderRadius.circular(kButtonBorderRadius),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerCard(BuildContext context, double width) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.primary.withOpacity(0.12),
      highlightColor: theme.colorScheme.secondary.withOpacity(0.18),
      child: Container(
        width: width,
        height: width * 0.65,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(kGlassOpacity),
          borderRadius: BorderRadius.circular(kCardBorderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * 0.14,
              height: width * 0.14,
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.18),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: width * 0.06),
            Container(
              width: width * 0.45,
              height: 20,
              color: theme.colorScheme.primary.withOpacity(0.18),
            ),
            SizedBox(height: width * 0.04),
            Container(
              width: width * 0.3,
              height: 20,
              color: theme.colorScheme.primary.withOpacity(0.12),
            ),
            SizedBox(height: width * 0.10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width * 0.2,
                  height: 16,
                  color: theme.colorScheme.primary.withOpacity(0.18),
                ),
                Container(
                  width: width * 0.08,
                  height: width * 0.08,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 