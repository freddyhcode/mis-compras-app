import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

Future<bool> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String primaryLabel,
  required String secondaryLabel,
  bool danger = false,
}) async {
  final colors = Theme.of(context).colorScheme;

  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppText(title, variant: AppTextVariant.title),
                const SizedBox(height: AppSpacing.sm),
                AppText(
                  body,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: secondaryLabel,
                        variant: AppButtonVariant.secondary,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: AppButton(
                        label: primaryLabel,
                        variant: danger
                            ? AppButtonVariant.danger
                            : AppButtonVariant.primary,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  return result ?? false;
}
