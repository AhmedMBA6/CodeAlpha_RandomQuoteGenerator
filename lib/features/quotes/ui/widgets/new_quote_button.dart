import 'package:flutter/material.dart';

class NewQuoteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewQuoteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.flash_on, color: theme.colorScheme.primary),
      label: const Text(
        'New Quote',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondary,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        shadowColor: theme.colorScheme.secondary.withOpacity(0.3),
      ),
    );
  }
} 