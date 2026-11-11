import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/utils/date.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class AppDateField extends StatelessWidget {
  const AppDateField({
    required this.label,
    required this.value,
    required this.onTap,
    this.requiredText,
    this.error,
    super.key,
  });

  final String label;
  final DateTime value;
  final VoidCallback onTap;
  final String? requiredText;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).languageCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: AppText(label, variant: AppTextVariant.label)),
            if (requiredText != null)
              AppText(
                requiredText!,
                variant: AppTextVariant.caption,
                color: colors.onSurfaceVariant,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        InkWell(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              errorText: error,
              suffixIcon: Icon(
                Icons.calendar_today_outlined,
                size: 20,
                color: colors.primary,
              ),
            ),
            child: AppText(
              formatDate(value, locale),
              variant: AppTextVariant.body,
            ),
          ),
        ),
      ],
    );
  }
}
