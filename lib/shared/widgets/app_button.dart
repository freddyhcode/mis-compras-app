import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

enum AppButtonVariant { primary, secondary, danger, ghost }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.fullWidth = false,
    this.loading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool fullWidth;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDisabled = onPressed == null || loading;

    final palette = switch (variant) {
      AppButtonVariant.primary => (
        background: colors.primary,
        border: colors.primary,
        text: colors.onPrimary,
      ),
      AppButtonVariant.secondary => (
        background: colors.surface,
        border: colors.primary,
        text: colors.primary,
      ),
      AppButtonVariant.danger => (
        background: colors.error,
        border: colors.error,
        text: colors.onError,
      ),
      AppButtonVariant.ghost => (
        background: Colors.transparent,
        border: Colors.transparent,
        text: colors.primary,
      ),
    };

    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: AppSpacing.xxxl,
        child: Material(
          color: palette.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            side: BorderSide(color: palette.border),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.md),
            onTap: isDisabled ? null : onPressed,
            child: Center(
              child: loading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: palette.text,
                      ),
                    )
                  : AppText(
                      label,
                      variant: AppTextVariant.label,
                      color: palette.text,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
