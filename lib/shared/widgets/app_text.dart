import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';

enum AppTextVariant { display, headline, title, body, small, caption, label }

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    this.variant = AppTextVariant.body,
    this.color,
    this.weight,
    this.align,
    this.maxLines,
    super.key,
  });

  final String text;
  final AppTextVariant variant;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? align;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final token = switch (variant) {
      AppTextVariant.display => AppTypography.display,
      AppTextVariant.headline => AppTypography.headline,
      AppTextVariant.title => AppTypography.title,
      AppTextVariant.body => AppTypography.body,
      AppTextVariant.small => AppTypography.small,
      AppTextVariant.caption => AppTypography.caption,
      AppTextVariant.label => AppTypography.label,
    };

    final style = TextStyle(
      fontSize: token.size,
      height: token.height(),
      fontWeight: token.weight,
      color: color,
    );

    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: weight == null ? style : style.copyWith(fontWeight: weight),
    );
  }
}
