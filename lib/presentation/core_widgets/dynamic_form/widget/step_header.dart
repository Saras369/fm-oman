import 'package:code_setup/modules/data/core/theme/services/dimensional/dimensional.dart';
import 'package:code_setup/utils/app_extensions/app_extension.dart';
import 'package:flutter/material.dart';

class StepHeader extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepHeader({super.key, required this.currentStep, required this.steps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (currentStep + 1) / steps.length;
    final currentTheme = KAppX.globalProvider
        .read(KAppX.theme.current)
        .themeBox;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step count
        Text(
          'Step ${currentStep + 1} of ${steps.length}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: currentTheme.fontSizes.s12,
          ),
        ),

        const SizedBox(height: 6),

        // Step title
        Text(
          steps[currentStep],
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: currentTheme.fontWeights.wBold,
            fontSize: currentTheme.fontSizes.s16,
          ),
        ),

        const SizedBox(height: 12),

        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progress),
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return LinearProgressIndicator(
                value: value,
                minHeight: 5.toAutoScaledHeight,
                backgroundColor: currentTheme.colors.primary.withAlpha(40),
                color: currentTheme.colors.primary,
              );
            },
          ),
        ),
      ],
    );
  }
}
