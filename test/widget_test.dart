import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mis_compras_app/core/errors/either.dart';
import 'package:mis_compras_app/core/errors/failure.dart';
import 'package:mis_compras_app/core/router/providers/router_provider.dart';
import 'package:mis_compras_app/features/home/presentation/screens/home_screen.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/repositories/purchase_repository.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';
import 'package:mis_compras_app/main.dart';

class _FakePurchaseRepository implements PurchaseRepository {
  @override
  Future<Either<Failure, List<PurchaseEntity>>> getAll() async {
    return Right<Failure, List<PurchaseEntity>>([]);
  }

  @override
  Future<Either<Failure, List<PurchaseEntity>>> getPage({
    required int limit,
    required int offset,
    String? search,
    String? category,
  }) async {
    return Right<Failure, List<PurchaseEntity>>([]);
  }

  @override
  Future<Either<Failure, bool>> delete(int id) async {
    return Right<Failure, bool>(true);
  }

  @override
  Future<Either<Failure, bool>> clearAll() async {
    return Right<Failure, bool>(true);
  }

  @override
  Future<Either<Failure, PurchaseEntity>> addItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PurchaseEntity>> duplicate(int id, String suffix) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PurchaseEntity>> getById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PurchaseEntity>> insert(PurchaseEntity purchase) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PurchaseEntity>> removeItem(
    int purchaseId,
    int itemId,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PurchaseEntity>> update(PurchaseEntity purchase) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PurchaseEntity>> updateItem(
    int purchaseId,
    PurchaseItemEntity item,
  ) {
    throw UnimplementedError();
  }
}

class _FakeRouterNotifier extends RouterNotifier {
  @override
  RouterState build() {
    return const RouterState(hasSeenTutorial: true, isLoading: false);
  }
}

void main() {
  testWidgets('muestra la pantalla de inicio', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          purchaseRepositoryProvider.overrideWith(
            (ref) => _FakePurchaseRepository(),
          ),
          routerProvider.overrideWith(_FakeRouterNotifier.new),
        ],
        child: const MisComprasApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
