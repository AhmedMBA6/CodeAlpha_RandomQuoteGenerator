import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
                child: Shimmer.fromColors(
                  baseColor: theme.colorScheme.primary.withOpacity(0.12),
                  highlightColor: theme.colorScheme.secondary.withOpacity(0.18),
                  child: Container(
                    width: double.infinity,
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: 180,
                          height: 20,
                          color: theme.colorScheme.primary.withOpacity(0.18),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: 120,
                          height: 20,
                          color: theme.colorScheme.primary.withOpacity(0.12),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 16,
                              color: theme.colorScheme.primary.withOpacity(0.18),
                            ),
                            Container(
                              width: 32,
                              height: 32,
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
                ),
              ),
            ),
            if (widget.showButtonShimmer) ...[
              const SizedBox(height: 32),
              Shimmer.fromColors(
                baseColor: theme.colorScheme.secondary.withOpacity(0.12),
                highlightColor: theme.colorScheme.primary.withOpacity(0.18),
                child: Container(
                  width: 180,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 