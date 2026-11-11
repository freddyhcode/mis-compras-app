import 'package:mis_compras_app/core/config/branding.dart';
import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/constants/constants.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';

class AboutScreen extends StatelessWidget {
  static const String name = 'about';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppTopBar(title: l10n.settingsAppInfo, showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  Branding.appName,
                  variant: AppTextVariant.headline,
                  color: colors.primary,
                ),
                const SizedBox(height: AppSpacing.xs),
                AppText(
                  '${l10n.settingsVersion} ${Constants.appVersion}',
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppText(
                  l10n.aboutWhatIs,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppText(
                  l10n.aboutLocal,
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: AppSpacing.sm),
                AppText(
                  '${l10n.aboutLicense}: ${l10n.aboutLicenseBody}',
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppText(
            l10n.aboutMadeIn,
            variant: AppTextVariant.caption,
            color: colors.onSurfaceVariant,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
