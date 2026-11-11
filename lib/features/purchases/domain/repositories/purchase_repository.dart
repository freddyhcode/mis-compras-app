import 'package:mis_compras_app/core/errors/either.dart';
import 'package:mis_compras_app/core/errors/failure.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';

abstract class PurchaseRepository {
  Future<Either<Failure, List<PurchaseEntity>>> getAll();

  Future<Either<Failure, List<PurchaseEntity>>> getPage({
    required int limit,
    required int offset,
    String? search,
    String? category,
  });

  Future<Either<Failure, PurchaseEntity>> getById(int id);

  Future<Either<Failure, PurchaseEntity>> insert(PurchaseEntity purchase);

  Future<Either<Failure, PurchaseEntity>> update(PurchaseEntity purchase);

  Future<Either<Failure, bool>> delete(int id);

  Future<Either<Failure, bool>> clearAll();

  Future<Either<Failure, PurchaseEntity>> duplicate(int id, String suffix);

  Future<Either<Failure, PurchaseEntity>> addItem(
    int purchaseId,
    PurchaseItemEntity item,
  );

  Future<Either<Failure, PurchaseEntity>> updateItem(
    int purchaseId,
    PurchaseItemEntity item,
  );

  Future<Either<Failure, PurchaseEntity>> removeItem(
    int purchaseId,
    int itemId,
  );
}
