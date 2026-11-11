import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({
    this.size = 42,
    this.variant = AppTextVariant.title,
    super.key,
  });

  final double size;
  final AppTextVariant variant;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: AppText('MC', variant: variant, color: colors.onPrimary),
          ),
        ),
      ),
    );
  }
}
