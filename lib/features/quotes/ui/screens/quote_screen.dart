import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import '../../logic/cubit/quote_cubit.dart';
import '../../logic/cubit/quote_state.dart';
import '../../../../core/app/routes.dart';
import '../../../../core/config/ui_constants.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuoteShot'),
        backgroundColor: theme.colorScheme.surface,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: theme.colorScheme.secondary),
            onPressed: () {
              Navigator.pushNamed(context, Routes.favorites);
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withAlpha((0.08 * 255).toInt()),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: BlocBuilder<QuoteCubit, QuoteState>(
          builder: (context, state) {
            return state.when(
              initial: () => _buildInitialState(context),
              loading: (isInitial) {
                if (isInitial) {
                  return const LoadingWidget(showButtonShimmer: true);
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: LoadingWidget(showButtonShimmer: false),
                        ),
                        const SizedBox(height: 24),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: kButtonMaxWidth),
                          child: NewQuoteButton(
                            onPressed: () {
                              context.read<QuoteCubit>().fetchRandomQuote();
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              success: (quote) => _buildSuccessState(context, quote),
              error: (error) => QuoteErrorWidget(
                error: error.statusMessage ?? 'An unknown error occurred',
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flash_on, color: theme.colorScheme.secondary, size: 56),
            const SizedBox(height: 24),
            Text(
              'Welcome to QuoteShot',
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: kButtonMaxWidth),
              child: NewQuoteButton(
                onPressed: () {
                  context.read<QuoteCubit>().fetchRandomQuote();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, quote) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: QuoteCard(quote: quote)),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: kButtonMaxWidth),
            child: NewQuoteButton(
              onPressed: () {
                context.read<QuoteCubit>().fetchRandomQuote();
              },
            ),
          ),
        ],
      ),
    );
  }
}
