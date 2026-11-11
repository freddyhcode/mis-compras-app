import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/theme/providers/theme_provider.dart';
import 'package:mis_compras_app/core/theme/theme_config.dart';
import 'package:mis_compras_app/features/settings/presentation/utils/settings_labels.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';

class AppearanceScreen extends ConsumerWidget {
  static const String name = 'appearance';

  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ref.watch(themeProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppTopBar(title: l10n.settingsAppearance, showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Section(
            title: l10n.settingsTheme,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _ThemeOption(
                      label: l10n.settingsLight,
                      isDark: false,
                      selected: !theme.isDarkMode,
                      accent: theme.accent,
                      onTap: () {
                        ref.read(themeProvider.notifier).toggleDarkMode(false);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _ThemeOption(
                      label: l10n.settingsDark,
                      isDark: true,
                      selected: theme.isDarkMode,
                      accent: theme.accent,
                      onTap: () {
                        ref.read(themeProvider.notifier).toggleDarkMode(true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.settingsAccent,
            children: [
              for (final accent in AppAccent.values)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _ColorOption(
                    label: accentLabel(l10n, accent),
                    accent: accent,
                    isDarkMode: theme.isDarkMode,
                    selected: theme.accent == accent,
                    onTap: () {
                      ref.read(themeProvider.notifier).setAccent(accent);
                    },
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppText(
            l10n.settingsAutoSave,
            variant: AppTextVariant.caption,
            color: colors.onSurfaceVariant,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.isDark,
    required this.selected,
    required this.accent,
    required this.onTap,
  });

  final String label;
  final bool isDark;
  final bool selected;
  final AppAccent accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final current = Theme.of(context).colorScheme;
    final preview = ThemeConfig.getTheme(isDarkMode: isDark, accent: accent);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: selected ? current.primaryContainer : current.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: selected ? current.primary : current.outlineVariant,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 76,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: preview.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: preview.colorScheme.outlineVariant),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.55,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: preview.colorScheme.primary,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: preview.colorScheme.onSurfaceVariant,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    FractionallySizedBox(
                      widthFactor: 0.45,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: preview.colorScheme.outlineVariant,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      label,
                      variant: AppTextVariant.label,
                      weight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check, size: 18, color: current.primary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  const _ColorOption({
    required this.label,
    required this.accent,
    required this.isDarkMode,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final AppAccent accent;
  final bool isDarkMode;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: selected ? colors.primaryContainer : colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: selected ? colors.primary : colors.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: ThemeConfig.accentColor(
                    accent: accent,
                    isDarkMode: isDarkMode,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  label,
                  variant: AppTextVariant.label,
                  weight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              if (selected) Icon(Icons.check, size: 18, color: colors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
