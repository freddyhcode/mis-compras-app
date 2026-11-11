import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';

const List<String> purchaseUnits = ['un', 'kg', 'L'];

int subtotalClp(PurchaseItemEntity item) {
  return ((item.quantityMilli * item.unitPriceClp) / 1000).round();
}

int purchaseTotalClp(PurchaseEntity purchase) {
  return purchase.items.fold(0, (total, item) => total + subtotalClp(item));
}

String monthKey(String isoDate) {
  return isoDate.length >= 7 ? isoDate.substring(0, 7) : isoDate;
}

int parseClpInput(String text) {
  final digits = text.replaceAll(RegExp(r'[^\d]'), '');
  if (digits.isEmpty) return 0;
  return int.tryParse(digits) ?? 0;
}

int parseQuantityInput(String text) {
  final normalized = text
      .replaceAll(',', '.')
      .replaceAll(RegExp(r'[^\d.]'), '');
  if (normalized.isEmpty) return 0;

  final value = double.tryParse(normalized);
  if (value == null || value <= 0) return 0;
  return (value * 1000).round();
}

String formatQuantityInput(int quantityMilli, String languageCode) {
  final text = (quantityMilli / 1000)
      .toStringAsFixed(3)
      .replaceFirst(RegExp(r'\.?0+$'), '');

  return languageCode == 'en' ? text : text.replaceAll('.', ',');
}

String formatQuantity(int quantityMilli, String unit, String languageCode) {
  if (unit == 'un') return (quantityMilli / 1000).round().toString();
  return formatQuantityInput(quantityMilli, languageCode);
}

String unitOptionLabel(AppLocalizations l10n, String unit) {
  return switch (unit) {
    'kg' => l10n.unitKg,
    'L' => l10n.unitL,
    _ => l10n.unitUn,
  };
}

String unitName(AppLocalizations l10n, String unit, int quantityMilli) {
  final isOne = quantityMilli == 1000;

  return switch (unit) {
    'kg' => isOne ? l10n.unitNameKgOne : l10n.unitNameKgOther,
    'L' => isOne ? l10n.unitNameLOne : l10n.unitNameLOther,
    _ => isOne ? l10n.unitNameUnOne : l10n.unitNameUnOther,
  };
}
