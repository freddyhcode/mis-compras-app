import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/config/branding.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';
import 'package:mis_compras_app/shared/widgets/section.dart';

class LegalScreen extends StatelessWidget {
  static const String name = 'legal';

  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppTopBar(title: l10n.legalTitle, showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: colors.outlineVariant),
                  ),
                  child: AppText(
                    l10n.legalDraft,
                    variant: AppTextVariant.small,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Section(
                  title: l10n.legalPrivacyTitle,
                  children: [
                    for (final paragraph in l10n.legalPrivacyBody.split('\n\n'))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppText(
                          paragraph,
                          variant: AppTextVariant.small,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Container(height: 1, color: colors.outlineVariant),
                const SizedBox(height: AppSpacing.md),
                Section(
                  title: l10n.legalTermsTitle,
                  children: [
                    for (final paragraph in l10n.legalTermsBody.split('\n\n'))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: AppText(
                          paragraph,
                          variant: AppTextVariant.small,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AppText(
                  l10n.legalFooter(Branding.appName),
                  variant: AppTextVariant.caption,
                  color: colors.onSurfaceVariant,
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
