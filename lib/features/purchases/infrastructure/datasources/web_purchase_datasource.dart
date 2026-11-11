import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/datasources/purchase_datasource.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';

class WebPurchaseDataSource implements PurchaseDataSource {
  final List<PurchaseEntity> _purchases = [];

  List<PurchaseEntity> _read() => [..._purchases];

  Future<void> _write(List<PurchaseEntity> purchases) async {
    _purchases
      ..clear()
      ..addAll(purchases);
  }

  @override
  Future<List<PurchaseEntity>> getAll() async {
    final purchases = _read();
    purchases.sort((a, b) {
      final byDate = b.purchasedAt.compareTo(a.purchasedAt);
      return byDate != 0 ? byDate : b.createdAt.compareTo(a.createdAt);
    });
    return purchases;
  }

  @override
  Future<List<PurchaseEntity>> getPage({
    required int limit,
    required int offset,
    String? search,
    String? category,
  }) async {
    final term = search?.trim().toLowerCase() ?? '';
    final purchases = _read().where((purchase) {
      if (category != null && category.isNotEmpty && category != 'all') {
        if (purchase.category != category) return false;
      }
      if (term.isEmpty) return true;

      final haystack = [
        purchase.title,
        purchase.merchant ?? '',
        purchase.notes ?? '',
        ...purchase.items.map((item) => item.name),
      ].join(' ').toLowerCase();

      return haystack.contains(term);
    }).toList();

    purchases.sort((a, b) {
      final byDate = b.purchasedAt.compareTo(a.purchasedAt);
      return byDate != 0 ? byDate : b.createdAt.compareTo(a.createdAt);
    });

    return purchases.skip(offset).take(limit).toList();
  }

  @override
  Future<PurchaseEntity> getById(int id) async {
    return _read().firstWhere((purchase) => purchase.id == id);
  }

  @override
  Future<PurchaseEntity> insert(PurchaseEntity purchase) async {
    final purchases = _read();
    final created = purchase.copyWith(
      id: DateTime.now().microsecondsSinceEpoch,
      items: const [],
    );
    purchases.add(created);
    await _write(purchases);
    return created;
  }

  @override
  Future<PurchaseEntity> update(PurchaseEntity purchase) async {
    final purchases = _read();
    final index = purchases.indexWhere((item) => item.id == purchase.id);
    if (index == -1) throw StateError('Purchase not found');

    purchases[index] = purchase;
    await _write(purchases);
    return purchase;
  }

  @override
  Future<bool> delete(int id) async {
    final purchases = _read();
    final filtered = purchases.where((item) => item.id != id).toList();
    if (filtered.length == purchases.length) return false;

    await _write(filtered);
    return true;
  }

  @override
  Future<void> clearAll() async {
    _purchases.clear();
  }

  @override
  Future<PurchaseEntity> duplicate(int id, String suffix) async {
    final purchases = _read();
    final index = purchases.indexWhere((purchase) => purchase.id == id);
    if (index == -1) throw StateError('Purchase not found');

    final source = purchases[index];
    final now = DateTime.now();
    final newId = now.microsecondsSinceEpoch;

    final copy = PurchaseEntity(
      id: newId,
      title: normalizeText('${source.title}$suffix'),
      purchasedAt: source.purchasedAt,
      merchant: source.merchant,
      category: source.category,
      notes: source.notes,
      createdAt: now,
      updatedAt: now,
      items: [
        for (var itemIndex = 0; itemIndex < source.items.length; itemIndex++)
          PurchaseItemEntity(
            id: newId + itemIndex + 1,
            purchaseId: newId,
            name: source.items[itemIndex].name,
            quantityMilli: source.items[itemIndex].quantityMilli,
            unit: source.items[itemIndex].unit,
            unitPriceClp: source.items[itemIndex].unitPriceClp,
            position: itemIndex,
            createdAt: now,
            updatedAt: now,
          ),
      ],
    );

    purchases.add(copy);
    await _write(purchases);
    return copy;
  }

  @override
  Future<PurchaseEntity> addItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) async {
    final purchases = _read();
    final index = purchases.indexWhere((purchase) => purchase.id == purchaseId);
    if (index == -1) throw StateError('Purchase not found');

    final now = DateTime.now();
    final created = item.copyWith(
      id: now.microsecondsSinceEpoch,
      purchaseId: purchaseId,
      position: purchases[index].items.length,
      createdAt: now,
      updatedAt: now,
    );
    final updated = purchases[index].copyWith(
      items: [...purchases[index].items, created],
      updatedAt: now,
    );

    purchases[index] = updated;
    await _write(purchases);
    return updated;
  }

  @override
  Future<PurchaseEntity> updateItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) async {
    final purchases = _read();
    final index = purchases.indexWhere((purchase) => purchase.id == purchaseId);
    if (index == -1) throw StateError('Purchase not found');

    final now = DateTime.now();
    final items = purchases[index].items
        .map(
          (entry) => entry.id == item.id
              ? item.copyWith(purchaseId: purchaseId, updatedAt: now)
              : entry,
        )
        .toList();
    final updated = purchases[index].copyWith(items: items, updatedAt: now);

    purchases[index] = updated;
    await _write(purchases);
    return updated;
  }

  @override
  Future<PurchaseEntity> removeItem(int purchaseId, int itemId) async {
    final purchases = _read();
    final index = purchases.indexWhere((purchase) => purchase.id == purchaseId);
    if (index == -1) throw StateError('Purchase not found');

    final now = DateTime.now();
    final items = purchases[index].items
        .where((item) => item.id != itemId)
        .toList();
    final updated = purchases[index].copyWith(items: items, updatedAt: now);

    purchases[index] = updated;
    await _write(purchases);
    return updated;
  }
}
