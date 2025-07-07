/// NewQuoteButton is a reusable button for fetching a new quote in the app.
import 'package:flutter/material.dart';
import 'package:codealpha_random_quote_generator/core/config/ui_constants.dart';

/// A button widget for requesting a new quote.
class NewQuoteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NewQuoteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.clamp(180.0, 400.0);
        final horizontalPadding = (width * 0.16).clamp(20.0, 48.0);
        final verticalPadding = (width * 0.07).clamp(12.0, 24.0);
        final iconSize = (width * 0.13).clamp(20.0, 32.0);
        final fontSize = (width * 0.09).clamp(14.0, 22.0);
        return SizedBox(
          width: width,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(Icons.flash_on, size: iconSize),
            label: Text(
              'New Quote',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(kGlassOpacity),
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kButtonBorderRadius),
              ),
              elevation: 6,
              shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            ),
          ),
        );
      },
    );
  }
} 