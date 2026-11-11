import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class Section extends StatelessWidget {
  const Section({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText(title, variant: AppTextVariant.title),
        const SizedBox(height: AppSpacing.sm),
        ...children,
      ],
    );
  }
}
