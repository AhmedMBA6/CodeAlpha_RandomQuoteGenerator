/// QuoteErrorWidget displays an error message for quote-related errors in the app.
import 'package:flutter/material.dart';

/// A widget that displays a user-friendly error message.
class QuoteErrorWidget extends StatelessWidget {
  final String error;
  const QuoteErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 16),
        textAlign: TextAlign.center,
        semanticsLabel: 'Error: $error',
      ),
    );
  }
} 