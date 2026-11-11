import 'package:mis_compras_app/core/utils/date.dart' hide monthKey;
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_format.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_labels.dart';

class MonthTotal {
  const MonthTotal({
    required this.key,
    required this.label,
    required this.total,
    required this.count,
    required this.products,
  });

  final String key;
  final String label;
  final int total;
  final int count;
  final int products;
}

class CategoryTotal {
  const CategoryTotal({required this.category, required this.total});

  final String category;
  final int total;
}

List<MonthTotal> monthTotals(
  List<PurchaseEntity> purchases,
  int months,
  String languageCode,
) {
  return _totalsForKeys(purchases, lastMonthKeys(months), languageCode);
}

List<MonthTotal> yearMonthTotals(
  List<PurchaseEntity> purchases,
  int year,
  String languageCode,
) {
  return _totalsForKeys(purchases, yearMonthKeys(year), languageCode);
}

List<MonthTotal> _totalsForKeys(
  List<PurchaseEntity> purchases,
  List<String> keys,
  String languageCode,
) {
  return keys.map((key) {
    final matching = purchases
        .where((purchase) => monthKey(purchase.purchasedAt) == key)
        .toList();

    return MonthTotal(
      key: key,
      label: monthLabel(key, languageCode),
      total: matching.fold(
        0,
        (sum, purchase) => sum + purchaseTotalClp(purchase),
      ),
      count: matching.length,
      products: matching.fold(
        0,
        (sum, purchase) => sum + purchase.items.length,
      ),
    );
  }).toList();
}

List<PurchaseEntity> purchasesInSeries(
  List<PurchaseEntity> purchases,
  List<MonthTotal> series,
) {
  final keys = series.map((entry) => entry.key).toSet();
  return purchases
      .where((purchase) => keys.contains(monthKey(purchase.purchasedAt)))
      .toList();
}

List<CategoryTotal> topCategories(
  List<PurchaseEntity> purchases, {
  int? limit,
}) {
  final totals = <String, int>{
    for (final category in purchaseCategories) category: 0,
  };

  for (final purchase in purchases) {
    final category = purchase.category ?? 'otros';
    totals[category] = (totals[category] ?? 0) + purchaseTotalClp(purchase);
  }

  final entries = totals.entries.toList()
    ..sort((a, b) {
      final byTotal = b.value.compareTo(a.value);
      if (byTotal != 0) return byTotal;
      return purchaseCategories
          .indexOf(a.key)
          .compareTo(purchaseCategories.indexOf(b.key));
    });

  return entries
      .take(limit ?? purchaseCategories.length)
      .map((entry) => CategoryTotal(category: entry.key, total: entry.value))
      .toList();
}
