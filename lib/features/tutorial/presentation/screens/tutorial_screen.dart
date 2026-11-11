import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/router/providers/router_provider.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/features/home/presentation/screens/home_screen.dart';
import 'package:mis_compras_app/shared/widgets/app_button.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/brand_mark.dart';

class TutorialScreen extends ConsumerWidget {
  static const String name = 'tutorial';

  const TutorialScreen({super.key});

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    await ref.read(routerProvider.notifier).markTutorialAsCompleted();

    if (context.mounted) {
      context.goNamed(HomeScreen.name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: BrandMark(
                        size: 56,
                        variant: AppTextVariant.headline,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppText(
                      l10n.tutorialTitle,
                      variant: AppTextVariant.headline,
                      color: colors.primary,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppText(
                      l10n.tutorialDescription,
                      variant: AppTextVariant.body,
                      color: colors.onSurfaceVariant,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    _Feature(
                      icon: Icons.palette_outlined,
                      text: l10n.tutorialTheme,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _Feature(
                      icon: Icons.lock_outline,
                      text: l10n.tutorialLocal,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _Feature(
                      icon: Icons.table_view_outlined,
                      text: l10n.tutorialData,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppText(
                      l10n.tutorialPrivacy,
                      variant: AppTextVariant.small,
                      color: colors.onSurfaceVariant,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      label: l10n.tutorialStart,
                      fullWidth: true,
                      onPressed: () => _start(context, ref),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  const _Feature({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(icon, size: 20, color: colors.primary),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: AppText(text, variant: AppTextVariant.small)),
      ],
    );
  }
}
