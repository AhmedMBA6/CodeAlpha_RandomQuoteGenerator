/// NewQuoteButton is a reusable button for fetching a new quote in the app.
library;
import 'package:flutter/material.dart';
import 'package:codealpha_random_quote_generator/core/config/ui_constants.dart';

/// Usage example (in your screen):
///
/// Center(
///   child: ConstrainedBox(
///     constraints: BoxConstraints(maxWidth: 320, minWidth: 180),
///     child: NewQuoteButton(onPressed: ...),
///   ),
/// )

/// A button widget for requesting a new quote.
class NewQuoteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewQuoteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.flash_on, size: 24),
        label: Text(
          'New Quote',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(kGlassOpacity),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kButtonBorderRadius),
          ),
          elevation: 6,
          shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
        ),
      ),
    );
  }
} 