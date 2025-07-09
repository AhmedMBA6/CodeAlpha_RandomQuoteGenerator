import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/widgets.dart';
import '../../logic/cubit/quote_cubit.dart';
import '../../logic/cubit/quote_state.dart';
import '../../../../core/app/routes.dart';
import '../../../../core/config/ui_constants.dart';
import '../../../../core/utils/shared_prefs_service.dart';
import '../../../../core/di/injection_container.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  bool? _showWelcome;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefsService = getIt<SharedPrefsService>();
    final isFirstLaunch = prefsService.getBool('is_first_launch', defaultValue: true);
    if (isFirstLaunch) {
      setState(() {
        _showWelcome = true;
      });
      await prefsService.setBool('is_first_launch', false);
    } else {
      setState(() {
        _showWelcome = false;
      });
      // Fetch a new quote immediately
      // ignore: use_build_context_synchronously
      context.read<QuoteCubit>().fetchRandomQuote();
    }
  }

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
        child: _showWelcome == null
            ? const Center(child: CircularProgressIndicator())
            : _showWelcome!
                ? _buildInitialState(context)
                : BlocBuilder<QuoteCubit, QuoteState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const SizedBox.shrink(),
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
                  setState(() {
                    _showWelcome = false;
                  });
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
