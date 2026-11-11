import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_stats.dart';

PurchaseEntity _purchase({
  required int id,
  required String title,
  required String category,
  required String purchasedAt,
  required int quantityMilli,
  required int unitPriceClp,
}) {
  final now = DateTime(2026, 10, 12);
  return PurchaseEntity(
    id: id,
    title: title,
    purchasedAt: purchasedAt,
    category: category,
    createdAt: now,
    updatedAt: now,
    items: [
      PurchaseItemEntity(
        id: id,
        purchaseId: id,
        name: 'Producto $id',
        quantityMilli: quantityMilli,
        unit: 'un',
        unitPriceClp: unitPriceClp,
        position: 0,
        createdAt: now,
        updatedAt: now,
      ),
    ],
  );
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
  });

  test('agrupa los totales por mes y cuenta productos', () {
    final purchases = [
      _purchase(
        id: 1,
        title: 'Compra 1',
        category: 'supermercado',
        purchasedAt: '2026-10-12',
        quantityMilli: 2000,
        unitPriceClp: 1000,
      ),
      _purchase(
        id: 2,
        title: 'Compra 2',
        category: 'online',
        purchasedAt: '2026-09-20',
        quantityMilli: 1000,
        unitPriceClp: 5000,
      ),
    ];

    final months = yearMonthTotals(purchases, 2026, 'es');

    expect(months.length, 12);
    expect(months[9].total, 2000);
    expect(months[9].count, 1);
    expect(months[9].products, 1);
    expect(months[8].total, 5000);
  });

  test('ordena categorías por total', () {
    final purchases = [
      _purchase(
        id: 1,
        title: 'Compra 1',
        category: 'supermercado',
        purchasedAt: '2026-10-12',
        quantityMilli: 1000,
        unitPriceClp: 1000,
      ),
      _purchase(
        id: 2,
        title: 'Compra 2',
        category: 'online',
        purchasedAt: '2026-10-12',
        quantityMilli: 1000,
        unitPriceClp: 5000,
      ),
    ];

    final categories = topCategories(purchases);

    expect(categories.first.category, 'online');
    expect(categories.first.total, 5000);
  });
}
