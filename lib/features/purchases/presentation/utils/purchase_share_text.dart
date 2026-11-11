import 'package:mis_compras_app/core/config/branding.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/utils/date.dart';
import 'package:mis_compras_app/core/utils/money.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';

String buildPurchaseShareText(
  PurchaseEntity purchase,
  AppLocalizations l10n,
  String languageCode,
) {
  final lines = <String?>[
    '${Branding.appName} · ${capitalizeText(purchase.title)}',
    '${l10n.purchaseDate}: ${formatIsoDate(purchase.purchasedAt, l10n.localeName)}',
    if (purchase.merchant != null)
      '${l10n.purchaseMerchant}: ${capitalizeText(purchase.merchant!)}',
    '${l10n.purchaseCategory}: '
        '${purchaseCategoryLabel(l10n, purchase.category)}',
    '',
    '${l10n.purchaseProducts}:',
    for (final item in purchase.items)
      '• ${formatQuantity(item.quantityMilli, item.unit, languageCode)} '
          '${unitName(l10n, item.unit, item.quantityMilli)} — '
          '${capitalizeText(item.name)}: ${formatClp(subtotalClp(item))}',
    '',
    '${l10n.purchaseTotal}: ${formatClp(purchaseTotalClp(purchase))}',
    if (purchase.notes != null)
      '${l10n.purchaseNotes}: ${capitalizeText(purchase.notes!)}',
  ];

  return lines.whereType<String>().join('\n');
}
