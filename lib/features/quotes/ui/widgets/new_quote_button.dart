/// NewQuoteButton is a reusable button for fetching a new quote in the app.
import 'package:flutter/material.dart';

/// A button widget for requesting a new quote.
class NewQuoteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewQuoteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.flash_on),
      label: const Text(
        'New Quote',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      ),
    );
  }
} 