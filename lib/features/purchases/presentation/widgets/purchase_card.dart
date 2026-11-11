import 'package:flutter/material.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/utils/date.dart';
import 'package:mis_compras_app/core/utils/money.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';
import 'package:mis_compras_app/shared/widgets/app_card.dart';
import 'package:mis_compras_app/shared/widgets/app_text.dart';

class PurchaseCard extends StatelessWidget {
  const PurchaseCard({required this.purchase, required this.onTap, super.key});

  final PurchaseEntity purchase;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).languageCode;

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  capitalizeText(purchase.title),
                  variant: AppTextVariant.label,
                  maxLines: 1,
                ),
                AppText(
                  '${formatIsoDate(purchase.purchasedAt, locale)}'
                  '${purchase.merchant != null ? ' · ${capitalizeText(purchase.merchant!)}' : ''}'
                  ' · ${l10n.purchaseProductCount(purchase.items.length)}',
                  variant: AppTextVariant.small,
                  color: colors.onSurfaceVariant,
                  maxLines: 1,
                ),
                AppText(
                  purchaseCategoryLabel(l10n, purchase.category),
                  variant: AppTextVariant.caption,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AppText(
            formatClp(purchaseTotalClp(purchase)),
            variant: AppTextVariant.label,
            color: colors.primary,
          ),
        ],
      ),
    );
  }
}
