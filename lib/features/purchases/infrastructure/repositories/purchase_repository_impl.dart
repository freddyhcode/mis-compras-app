import 'package:flutter/foundation.dart';
import 'package:mis_compras_app/core/errors/database_error_type.dart';
import 'package:mis_compras_app/core/errors/either.dart';
import 'package:mis_compras_app/core/errors/failure.dart';
import 'package:mis_compras_app/features/purchases/domain/datasources/purchase_datasource.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/repositories/purchase_repository.dart';
import 'package:mis_compras_app/features/purchases/infrastructure/datasources/purchase_datasource_impl.dart';
import 'package:mis_compras_app/features/purchases/infrastructure/datasources/web_purchase_datasource.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  PurchaseRepositoryImpl({PurchaseDataSource? dataSource})
    : _dataSource = dataSource ?? _defaultDataSource();

  static PurchaseDataSource _defaultDataSource() {
    if (kIsWeb) return WebPurchaseDataSource();
    return PurchaseDataSourceImpl();
  }

  final PurchaseDataSource _dataSource;

  @override
  Future<Either<Failure, List<PurchaseEntity>>> getAll() async {
    try {
      return Right(await _dataSource.getAll());
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.getFailed));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseEntity>>> getPage({
    required int limit,
    required int offset,
    String? search,
    String? category,
  }) async {
    try {
      return Right(
        await _dataSource.getPage(
          limit: limit,
          offset: offset,
          search: search,
          category: category,
        ),
      );
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.getFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> getById(int id) async {
    try {
      return Right(await _dataSource.getById(id));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.getFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> insert(
    PurchaseEntity purchase,
  ) async {
    try {
      return Right(await _dataSource.insert(purchase));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.insertFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> update(
    PurchaseEntity purchase,
  ) async {
    try {
      return Right(await _dataSource.update(purchase));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.updateFailed));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    try {
      return Right(await _dataSource.delete(id));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.deleteFailed));
    }
  }

  @override
  Future<Either<Failure, bool>> clearAll() async {
    try {
      await _dataSource.clearAll();
      return const Right(true);
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.deleteFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> duplicate(
    int id,
    String suffix,
  ) async {
    try {
      return Right(await _dataSource.duplicate(id, suffix));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.insertFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> addItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) async {
    try {
      return Right(await _dataSource.addItem(purchaseId, item));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.insertFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> updateItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) async {
    try {
      return Right(await _dataSource.updateItem(purchaseId, item));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.updateFailed));
    }
  }

  @override
  Future<Either<Failure, PurchaseEntity>> removeItem(
    int purchaseId,
    int itemId,
  ) async {
    try {
      return Right(await _dataSource.removeItem(purchaseId, itemId));
    } catch (error) {
      return Left(DatabaseFailure(DatabaseErrorType.deleteFailed));
    }
  }
}
