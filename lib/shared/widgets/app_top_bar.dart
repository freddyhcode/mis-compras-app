import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/brand_mark.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    required this.title,
    this.actions,
    this.showBack = false,
    this.onBack,
    this.brand = false,
    super.key,
  });

  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final bool brand;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hasLeading = showBack || brand;

    final Widget? leading = showBack
        ? IconButton(
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
          )
        : brand
        ? const Center(child: BrandMark())
        : null;

    return AppBar(
      title: AppText(title, variant: AppTextVariant.title, maxLines: 1),
      centerTitle: false,
      titleSpacing: hasLeading ? AppSpacing.md : AppSpacing.lg,
      leadingWidth: hasLeading ? 58 : null,
      leading: leading,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: colors.outlineVariant),
      ),
    );
  }
}
