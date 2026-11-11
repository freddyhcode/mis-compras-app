import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/config/branding.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/theme/app_tokens.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';
import 'package:mis_compras_app/shared/widgets/app_top_bar.dart';

class CreatorScreen extends StatelessWidget {
  static const String name = 'creator';

  const CreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final creator = Branding.creator.trim();
    final hasCreator = creator.isNotEmpty;
    final initial = hasCreator ? creator[0].toUpperCase() : '?';

    final links = <Widget>[
      if (Branding.website.trim().isNotEmpty)
        _LinkRow(
          icon: Icons.language_outlined,
          label: l10n.creatorWebsite,
          value: Branding.website,
        ),
      if (Branding.github.trim().isNotEmpty)
        _LinkRow(
          icon: Icons.code_outlined,
          label: l10n.creatorGithub,
          value: Branding.github,
        ),
      if (Branding.contact.trim().isNotEmpty)
        _LinkRow(
          icon: Icons.mail_outline,
          label: l10n.creatorContact,
          value: Branding.contact,
        ),
      if (Branding.support.trim().isNotEmpty)
        _LinkRow(
          icon: Icons.coffee_outlined,
          label: l10n.creatorSupport,
          value: Branding.support,
        ),
    ];

    return Scaffold(
      appBar: AppTopBar(title: l10n.settingsCreator, showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  alignment: Alignment.center,
                  child: AppText(
                    initial,
                    variant: AppTextVariant.headline,
                    color: colors.onPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        hasCreator ? creator : l10n.creatorNotSet,
                        variant: AppTextVariant.title,
                      ),
                      AppText(
                        l10n.aboutMadeIn,
                        variant: AppTextVariant.small,
                        color: colors.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (links.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            AppCard(
              child: Column(
                children: [
                  for (var index = 0; index < links.length; index++) ...[
                    if (index > 0) const Divider(height: 1),
                    links[index],
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LinkRow extends StatelessWidget {
  const _LinkRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colors.primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  label,
                  variant: AppTextVariant.caption,
                  color: colors.onSurfaceVariant,
                ),
                AppText(value, variant: AppTextVariant.small),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
