import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(Icons.inbox_outlined, size: 30, color: colors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                AppText(
                  title,
                  variant: AppTextVariant.title,
                  align: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppText(
                  description,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: AppSpacing.md),
            AppButton(label: actionLabel!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}
