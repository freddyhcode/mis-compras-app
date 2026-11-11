import 'package:mis_compras_app/core/l10n/app_localizations.dart';

const List<String> purchaseCategories = [
  'supermercado',
  'online',
  'hogar',
  'tecnologia',
  'ropa',
  'otros',
];

String purchaseCategoryLabel(AppLocalizations l10n, String? category) {
  return switch (category) {
    'supermercado' => l10n.categorySupermercado,
    'online' => l10n.categoryOnline,
    'hogar' => l10n.categoryHogar,
    'tecnologia' => l10n.categoryTecnologia,
    'ropa' => l10n.categoryRopa,
    _ => l10n.categoryOtros,
  };
}
