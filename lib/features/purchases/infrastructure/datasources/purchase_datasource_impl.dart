import 'package:mis_compras_app/core/constants/constants.dart';
import 'package:mis_compras_app/core/services/local_database/local_database.dart';
import 'package:mis_compras_app/core/services/local_database/local_database_impl.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/datasources/purchase_datasource.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/infrastructure/mappers/purchase_item_mapper.dart';
import 'package:mis_compras_app/features/purchases/infrastructure/mappers/purchase_mapper.dart';

class PurchaseDataSourceImpl implements PurchaseDataSource {
  PurchaseDataSourceImpl({LocalDatabase? localDatabase})
    : _localDatabase = localDatabase ?? LocalDatabaseImpl();

  final LocalDatabase _localDatabase;

  @override
  Future<List<PurchaseEntity>> getAll() async {
    final db = await _localDatabase.connection();
    final rows = await db.query(
      Constants.db.tablePurchases,
      orderBy: 'purchased_at DESC, created_at DESC',
    );
    final itemRows = await db.query(
      Constants.db.tablePurchaseItems,
      orderBy: 'position ASC, created_at ASC',
    );

    final byPurchase = <int, List<PurchaseItemEntity>>{};
    for (final row in itemRows) {
      final item = PurchaseItemMapper.fromMap(row);
      byPurchase.putIfAbsent(item.purchaseId, () => []).add(item);
    }

    return rows
        .map(
          (row) => PurchaseMapper.fromMap(
            row,
            items: byPurchase[row['id'] as int] ?? const [],
          ),
        )
        .toList();
  }

  @override
  Future<List<PurchaseEntity>> getPage({
    required int limit,
    required int offset,
    String? search,
    String? category,
  }) async {
    final db = await _localDatabase.connection();
    final conditions = <String>[];
    final args = <Object?>[];

    if (category != null && category.isNotEmpty && category != 'all') {
      conditions.add('p.category = ?');
      args.add(category);
    }

    final term = search?.trim().toLowerCase() ?? '';
    if (term.isNotEmpty) {
      final like = '%$term%';
      conditions.add(
        '(p.title LIKE ? OR COALESCE(p.merchant, \'\') LIKE ? '
        'OR COALESCE(p.notes, \'\') LIKE ? '
        'OR EXISTS (SELECT 1 FROM ${Constants.db.tablePurchaseItems} i '
        'WHERE i.purchase_id = p.id AND i.name LIKE ?))',
      );
      args.addAll([like, like, like, like]);
    }

    final where = conditions.isEmpty ? '' : 'WHERE ${conditions.join(' AND ')}';
    final rows = await db.rawQuery(
      'SELECT p.* FROM ${Constants.db.tablePurchases} p $where '
      'ORDER BY p.purchased_at DESC, p.created_at DESC '
      'LIMIT ? OFFSET ?',
      [...args, limit, offset],
    );

    if (rows.isEmpty) return [];

    final ids = rows.map((row) => row['id'] as int).toList();
    final placeholders = List.filled(ids.length, '?').join(',');
    final itemRows = await db.query(
      Constants.db.tablePurchaseItems,
      where: 'purchase_id IN ($placeholders)',
      whereArgs: ids,
      orderBy: 'position ASC, created_at ASC',
    );

    final byPurchase = <int, List<PurchaseItemEntity>>{};
    for (final row in itemRows) {
      final item = PurchaseItemMapper.fromMap(row);
      byPurchase.putIfAbsent(item.purchaseId, () => []).add(item);
    }

    return rows
        .map(
          (row) => PurchaseMapper.fromMap(
            row,
            items: byPurchase[row['id'] as int] ?? const [],
          ),
        )
        .toList();
  }

  @override
  Future<PurchaseEntity> getById(int id) async {
    final db = await _localDatabase.connection();
    final rows = await db.query(
      Constants.db.tablePurchases,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (rows.isEmpty) throw StateError('Purchase not found');

    final itemRows = await db.query(
      Constants.db.tablePurchaseItems,
      where: 'purchase_id = ?',
      whereArgs: [id],
      orderBy: 'position ASC, created_at ASC',
    );

    return PurchaseMapper.fromMap(
      rows.first,
      items: itemRows.map(PurchaseItemMapper.fromMap).toList(),
    );
  }

  @override
  Future<PurchaseEntity> insert(PurchaseEntity purchase) async {
    final db = await _localDatabase.connection();
    final data = PurchaseMapper.toMap(purchase)..remove('id');
    final id = await db.insert(Constants.db.tablePurchases, data);

    return purchase.copyWith(id: id, items: const []);
  }

  @override
  Future<PurchaseEntity> update(PurchaseEntity purchase) async {
    final db = await _localDatabase.connection();
    final data = PurchaseMapper.toMap(purchase)..remove('id');

    await db.update(
      Constants.db.tablePurchases,
      data,
      where: 'id = ?',
      whereArgs: [purchase.id],
    );

    return purchase;
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _localDatabase.connection();
    final deleted = await db.delete(
      Constants.db.tablePurchases,
      where: 'id = ?',
      whereArgs: [id],
    );

    return deleted > 0;
  }

  @override
  Future<void> clearAll() async {
    await _localDatabase.reset();
  }

  @override
  Future<PurchaseEntity> duplicate(int id, String suffix) async {
    final db = await _localDatabase.connection();
    final source = await getById(id);
    final now = DateTime.now();
    late int newId;

    await db.transaction((transaction) async {
      final data = PurchaseMapper.toMap(
        PurchaseEntity(
          title: normalizeText('${source.title}$suffix'),
          purchasedAt: source.purchasedAt,
          merchant: source.merchant,
          category: source.category,
          notes: source.notes,
          createdAt: now,
          updatedAt: now,
        ),
      )..remove('id');

      newId = await transaction.insert(Constants.db.tablePurchases, data);

      for (var index = 0; index < source.items.length; index++) {
        final sourceItem = source.items[index];
        final itemData = PurchaseItemMapper.toMap(
          PurchaseItemEntity(
            purchaseId: newId,
            name: sourceItem.name,
            quantityMilli: sourceItem.quantityMilli,
            unit: sourceItem.unit,
            unitPriceClp: sourceItem.unitPriceClp,
            position: index,
            createdAt: now,
            updatedAt: now,
          ),
        )..remove('id');

        await transaction.insert(Constants.db.tablePurchaseItems, itemData);
      }
    });

    return getById(newId);
  }

  @override
  Future<PurchaseEntity> addItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) async {
    final db = await _localDatabase.connection();
    final now = DateTime.now();

    await db.transaction((transaction) async {
      final rows = await transaction.rawQuery(
        'SELECT COALESCE(MAX(position), -1) + 1 AS next '
        'FROM ${Constants.db.tablePurchaseItems} WHERE purchase_id = ?',
        [purchaseId],
      );
      final position = (rows.first['next'] as int?) ?? 0;
      final data = PurchaseItemMapper.toMap(
        item.copyWith(
          purchaseId: purchaseId,
          position: position,
          createdAt: now,
          updatedAt: now,
        ),
      )..remove('id');

      await transaction.insert(Constants.db.tablePurchaseItems, data);
      await transaction.update(
        Constants.db.tablePurchases,
        {'updated_at': now.toIso8601String()},
        where: 'id = ?',
        whereArgs: [purchaseId],
      );
    });

    return getById(purchaseId);
  }

  @override
  Future<PurchaseEntity> updateItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) async {
    final db = await _localDatabase.connection();
    final now = DateTime.now();

    await db.transaction((transaction) async {
      final data = PurchaseItemMapper.toMap(
        item.copyWith(purchaseId: purchaseId, updatedAt: now),
      )..remove('id');

      await transaction.update(
        Constants.db.tablePurchaseItems,
        data,
        where: 'id = ? AND purchase_id = ?',
        whereArgs: [item.id, purchaseId],
      );
      await transaction.update(
        Constants.db.tablePurchases,
        {'updated_at': now.toIso8601String()},
        where: 'id = ?',
        whereArgs: [purchaseId],
      );
    });

    return getById(purchaseId);
  }

  @override
  Future<PurchaseEntity> removeItem(int purchaseId, int itemId) async {
    final db = await _localDatabase.connection();
    final now = DateTime.now();

    await db.transaction((transaction) async {
      await transaction.delete(
        Constants.db.tablePurchaseItems,
        where: 'id = ? AND purchase_id = ?',
        whereArgs: [itemId, purchaseId],
      );
      await transaction.update(
        Constants.db.tablePurchases,
        {'updated_at': now.toIso8601String()},
        where: 'id = ?',
        whereArgs: [purchaseId],
      );
    });

    return getById(purchaseId);
  }
}
