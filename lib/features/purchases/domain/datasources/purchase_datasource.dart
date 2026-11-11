import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';

abstract class PurchaseDataSource {
  Future<List<PurchaseEntity>> getAll();

  Future<List<PurchaseEntity>> getPage({
    required int limit,
    required int offset,
    String? search,
    String? category,
  });

  Future<PurchaseEntity> getById(int id);

  Future<PurchaseEntity> insert(PurchaseEntity purchase);

  Future<PurchaseEntity> update(PurchaseEntity purchase);

  Future<bool> delete(int id);

  Future<void> clearAll();

  Future<PurchaseEntity> duplicate(int id, String suffix);

  Future<PurchaseEntity> addItem(int purchaseId, PurchaseItemEntity item);

  Future<PurchaseEntity> updateItem(int purchaseId, PurchaseItemEntity item);

  Future<PurchaseEntity> removeItem(int purchaseId, int itemId);
}
