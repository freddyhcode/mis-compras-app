import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    required this.label,
    this.controller,
    this.placeholder,
    this.help,
    this.error,
    this.required = false,
    this.requiredText,
    this.multiline = false,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    super.key,
  });

  final String label;
  final TextEditingController? controller;
  final String? placeholder;
  final String? help;
  final String? error;
  final bool required;
  final String? requiredText;
  final bool multiline;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: AppText(label, variant: AppTextVariant.label)),
            if (required && requiredText != null)
              AppText(
                requiredText!,
                variant: AppTextVariant.caption,
                color: colors.onSurfaceVariant,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          minLines: multiline ? 4 : 1,
          maxLines: multiline ? 6 : 1,
          maxLength: maxLength,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            errorText: error,
            helperText: error == null ? help : null,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
