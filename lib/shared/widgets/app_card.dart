import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.backgroundColor,
    this.borderColor,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final content = Padding(padding: padding, child: child);
    final decoration = BoxDecoration(
      color: backgroundColor ?? colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.md),
      border: Border.all(color: borderColor ?? colors.outlineVariant),
    );

    if (onTap == null) {
      return Container(decoration: decoration, child: content);
    }

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: decoration,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          splashColor: colors.primaryContainer,
          highlightColor: colors.primaryContainer,
          onTap: onTap,
          child: content,
        ),
      ),
    );
  }
}
