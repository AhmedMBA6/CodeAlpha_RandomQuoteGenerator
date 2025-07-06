import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/quote_card.dart';
import '../widgets/new_quote_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import '../../logic/cubit/quote_cubit.dart';
import '../../logic/cubit/quote_state.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuoteShot'),
        backgroundColor: theme.colorScheme.background,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: theme.colorScheme.secondary),
            onPressed: () {
              // TODO: Navigate to favorites screen
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
              theme.colorScheme.primary.withOpacity(0.08),
              theme.colorScheme.background,
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
                        const Expanded(child: LoadingWidget(showButtonShimmer: false)),
                        const SizedBox(height: 24),
                        NewQuoteButton(
                          onPressed: () {
                            context.read<QuoteCubit>().fetchRandomQuote();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              success: (quote) => _buildSuccessState(context, quote),
              error: (error) => QuoteErrorWidget(error: error),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
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
          NewQuoteButton(
            onPressed: () {
              context.read<QuoteCubit>().fetchRandomQuote();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, quote) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: QuoteCard(quote: quote),
          ),
          const SizedBox(height: 24),
          NewQuoteButton(
            onPressed: () {
              context.read<QuoteCubit>().fetchRandomQuote();
            },
          ),
        ],
      ),
    );
  }
} 