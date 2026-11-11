import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    required this.icon,
    required this.title,
    this.description,
    this.onTap,
    this.trailing,
    this.destructive = false,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final content = Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: destructive
                ? colors.errorContainer
                : colors.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            icon,
            size: 20,
            color: destructive ? colors.error : colors.primary,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                variant: AppTextVariant.label,
                color: destructive ? colors.error : null,
              ),
              if (description != null) ...[
                const SizedBox(height: 2),
                AppText(
                  description!,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ),
        trailing ??
            (onTap != null
                ? Icon(Icons.chevron_right, color: colors.onSurfaceVariant)
                : const SizedBox.shrink()),
      ],
    );

    final container = Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: content,
    );

    if (onTap == null) return container;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        splashColor: colors.primaryContainer,
        highlightColor: colors.primaryContainer,
        onTap: onTap,
        child: container,
      ),
    );
  }
}
