import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection_app/providers/spam_provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Email Spam Detector'),
        backgroundColor: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Hero Section
              _HeroSection(colorScheme: colorScheme, textTheme: textTheme),
              const SizedBox(height: 28),

              // ── Input Card
              _InputCard(
                controller: _messageController,
                colorScheme: colorScheme,
                textTheme: textTheme,
              ),
              const SizedBox(height: 16),

              // ── Analyze Button
              _AnalyzeButton(
                controller: _messageController,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 24),

              //  Dynamic Result / Loading / Error area
              Consumer<SpamProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return _LoadingIndicator(colorScheme: colorScheme);
                  }
                  if (provider.hasError) {
                    return _ErrorCard(
                      message: provider.error,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    );
                  }
                  if (provider.hasResult) {
                    return _ResultCard(
                      prediction: provider.prediction,
                      confidence: provider.confidence,
                      colorScheme: colorScheme,
                      textTheme: textTheme,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Hero Section

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.colorScheme, required this.textTheme});

  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.security_rounded,
            size: 44,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'AI Email Spam Detection',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Paste an email or SMS and let the model\ndetermine whether it is spam.',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// Input Card

class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.controller,
    required this.colorScheme,
    required this.textTheme,
  });

  final TextEditingController controller;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          minLines: 5,
          maxLines: 10,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
            height: 1.6,
          ),
          decoration: InputDecoration(
            hintText: 'Paste email content here...',
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}

// Analyze Button

class _AnalyzeButton extends StatelessWidget {
  const _AnalyzeButton({required this.controller, required this.colorScheme});

  final TextEditingController controller;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Consumer<SpamProvider>(
      builder: (context, provider, _) {
        final isDisabled = provider.isLoading;

        return FilledButton.icon(
          onPressed: isDisabled
              ? null
              : () {
                  final text = controller.text.trim();
                  if (text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Please enter an email or message first.',
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                    return;
                  }
                  context.read<SpamProvider>().detectSpam(text);
                },
          icon: const Icon(Icons.search_rounded),
          label: const Text('Analyze Message'),
          style: FilledButton.styleFrom(
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        );
      },
    );
  }
}

// Loading Indicator

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Column(
          children: [
            CircularProgressIndicator(
              color: colorScheme.primary,
              strokeWidth: 3,
            ),
            const SizedBox(height: 16),
            Text(
              'Analyzing message…',
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Result Card

class _ResultCard extends StatelessWidget {
  const _ResultCard({
    required this.prediction,
    required this.confidence,
    required this.colorScheme,
    required this.textTheme,
  });

  final String prediction;
  final double confidence;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final isSpam = prediction.toLowerCase() == 'spam';

    final accentColor = isSpam
        ? const Color(0xFFBA1A1A) // Material red
        : const Color(0xFF1A6B38); // Material green

    final containerColor = isSpam
        ? const Color(0xFFFFDAD6)
        : const Color(0xFFBFF0D0);

    final icon = isSpam ? Icons.warning_amber_rounded : Icons.verified_rounded;

    final label = isSpam ? 'Spam Detected' : 'Safe Message';
    final confidencePct = (confidence * 100).toStringAsFixed(2);

    return Card(
      elevation: 0,
      color: containerColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: accentColor.withValues(alpha: 0.35), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, color: accentColor, size: 48),
            const SizedBox(height: 10),
            Text(
              label,
              style: textTheme.titleLarge?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            _Divider(color: accentColor),
            const SizedBox(height: 14),
            _ResultRow(
              label: 'Prediction',
              value: prediction,
              valueColor: accentColor,
              textTheme: textTheme,
            ),
            const SizedBox(height: 8),
            _ResultRow(
              label: 'Confidence',
              value: '$confidencePct%',
              valueColor: accentColor,
              textTheme: textTheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Divider(color: color.withValues(alpha: 0.25), thickness: 1);
  }
}

class _ResultRow extends StatelessWidget {
  const _ResultRow({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.textTheme,
  });

  final String label;
  final String value;
  final Color valueColor;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(
            color: valueColor.withValues(alpha: 0.75),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: textTheme.bodyMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// Error Card

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({
    required this.message,
    required this.colorScheme,
    required this.textTheme,
  });

  final String message;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.errorContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.error.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: colorScheme.onErrorContainer,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Failed',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onErrorContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onErrorContainer,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
