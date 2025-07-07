/// QuoteErrorWidget displays an error message for quote-related errors in the app.
library;
import 'package:flutter/material.dart';
import 'package:codealpha_random_quote_generator/core/config/ui_constants.dart';

/// A widget that displays a user-friendly error message.
class QuoteErrorWidget extends StatelessWidget {
  final String error;
  const QuoteErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.clamp(200.0, 600.0);
        final fontSize = (width * 0.06).clamp(14.0, 24.0);
        final padding = kDefaultPadding;
        return Center(
          child: Semantics(
            label: 'Error: $error',
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: fontSize, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
} 