import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    required this.selected,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: selected ? colors.primaryContainer : colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        side: BorderSide(
          color: selected ? colors.primary : colors.outlineVariant,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: AppText(
                label,
                variant: AppTextVariant.small,
                weight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? colors.primary : colors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
