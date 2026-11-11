import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mis_compras_app/core/config/app_config.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/l10n/providers/language_provider.dart';
import 'package:mis_compras_app/core/router/providers/router_provider.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/core/theme/providers/theme_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/about_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/appearance_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/creator_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/screens/legal_screen.dart';
import 'package:mis_compras_app/features/settings/presentation/utils/settings_labels.dart';
import 'package:mis_compras_app/features/tutorial/presentation/screens/tutorial_screen.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_chip.dart';
import 'package:mis_compras_app/shared/widgets/app_confirm_dialog.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';
import 'package:mis_compras_app/shared/widgets/settings_row.dart';

class SettingsScreen extends ConsumerWidget {
  static const String name = 'settings';

  const SettingsScreen({super.key});

  Future<void> _seedPurchases(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showAppConfirmDialog(
      context: context,
      title: l10n.settingsSeed,
      body: l10n.settingsSeedBody,
      primaryLabel: l10n.settingsSeedConfirm,
      secondaryLabel: l10n.commonCancel,
    );

    if (!confirmed || !context.mounted) return;

    final count = await ref.read(purchaseProvider.notifier).seedData();
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          count == null
              ? l10n.settingsSeedError
              : l10n.settingsSeedSuccess(count),
        ),
      ),
    );
  }

  Future<void> _exportData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    final exported = await ref.read(purchaseProvider.notifier).exportData(l10n);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          exported ? l10n.settingsExportSuccess : l10n.settingsExportError,
        ),
      ),
    );
  }

  Future<void> _deleteAllData(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showAppConfirmDialog(
      context: context,
      title: l10n.settingsDeleteTitle,
      body: l10n.settingsDeleteBody,
      primaryLabel: l10n.settingsDeleteConfirm,
      secondaryLabel: l10n.commonCancel,
      danger: true,
    );

    if (!confirmed || !context.mounted) return;

    try {
      final result = await ref.read(purchaseProvider.notifier).resetAll();
      final cleared = result.fold((failure) => false, (value) => value);
      if (!cleared) {
        throw StateError('No se pudieron eliminar los datos.');
      }

      await ref.read(themeProvider.notifier).reset();
      await ref.read(languageProvider.notifier).reset();
      await ref.read(routerProvider.notifier).resetTutorial();

      if (!context.mounted) return;
      context.goNamed(TutorialScreen.name);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.settingsDeleteSuccess)));
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.settingsDeleteError)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final language = ref.watch(languageProvider);
    final theme = ref.watch(themeProvider);
    final colors = Theme.of(context).colorScheme;
    final modeLabel = switch (AppConfig.mode()) {
      AppMode.development => l10n.settingsModeDevelopment,
      AppMode.demo => l10n.settingsModeDemo,
      AppMode.production => l10n.settingsModeProduction,
    };

    return Scaffold(
      appBar: AppTopBar(title: l10n.settingsTitle, brand: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Section(
            title: l10n.settingsLanguage,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppChip(
                    label: l10n.settingsSpanish,
                    selected: language.languageCode == 'es',
                    onPressed: () {
                      ref.read(languageProvider.notifier).setLanguage('es');
                    },
                  ),
                  AppChip(
                    label: l10n.settingsEnglish,
                    selected: language.languageCode == 'en',
                    onPressed: () {
                      ref.read(languageProvider.notifier).setLanguage('en');
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.settingsAppearance,
            children: [
              SettingsRow(
                icon: Icons.palette_outlined,
                title: l10n.settingsAppearance,
                description:
                    '${themeLabel(l10n, theme.isDarkMode)} · ${accentLabel(l10n, theme.accent)}',
                onTap: () {
                  context.pushNamed(AppearanceScreen.name);
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.settingsData,
            children: [
              SettingsRow(
                icon: Icons.download_outlined,
                title: l10n.settingsExport,
                description: l10n.settingsExportDesc,
                onTap: () => _exportData(context, ref),
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsRow(
                icon: Icons.delete_outline,
                title: l10n.settingsDeleteAll,
                description: l10n.settingsDeleteAllDesc,
                destructive: true,
                onTap: () => _deleteAllData(context, ref),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.settingsLegalSection,
            children: [
              SettingsRow(
                icon: Icons.description_outlined,
                title: l10n.settingsLegal,
                description: l10n.settingsLegalDesc,
                onTap: () {
                  context.pushNamed(LegalScreen.name);
                },
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Section(
            title: l10n.settingsAboutSection,
            children: [
              SettingsRow(
                icon: Icons.person_outline,
                title: l10n.settingsCreator,
                description: l10n.settingsCreatorDesc,
                onTap: () {
                  context.pushNamed(CreatorScreen.name);
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              SettingsRow(
                icon: Icons.phone_iphone_outlined,
                title: l10n.settingsAppInfo,
                description: l10n.settingsAppInfoDesc,
                onTap: () {
                  context.pushNamed(AboutScreen.name);
                },
              ),
            ],
          ),
          if (!kReleaseMode && AppConfig.isDevelopment()) ...[
            const SizedBox(height: AppSpacing.md),
            Section(
              title: l10n.settingsDev,
              children: [
                SettingsRow(
                  icon: Icons.construction_outlined,
                  title: l10n.settingsMode,
                  description: modeLabel,
                ),
                const SizedBox(height: AppSpacing.sm),
                SettingsRow(
                  icon: Icons.science_outlined,
                  title: l10n.settingsSeed,
                  description: l10n.settingsSeedDesc,
                  onTap: () => _seedPurchases(context, ref),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          AppCard(
            child: AppText(
              l10n.settingsPrivacy,
              variant: AppTextVariant.small,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
