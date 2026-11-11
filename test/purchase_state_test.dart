import 'package:flutter_test/flutter_test.dart';
import 'package:mis_compras_app/core/errors/database_error_type.dart';
import 'package:mis_compras_app/core/errors/failure.dart';
import 'package:mis_compras_app/features/purchases/presentation/providers/purchase_provider.dart';

void main() {
  group('PurchaseState.copyWith', () {
    test('conserva el error cuando no se especifica', () {
      const failure = DatabaseFailure(DatabaseErrorType.getFailed);
      const state = PurchaseState(errorType: failure);

      final next = state.copyWith(isLoading: true);

      expect(next.errorType, failure);
      expect(next.isLoading, isTrue);
    });

    test('limpia el error cuando se pasa null', () {
      const failure = DatabaseFailure(DatabaseErrorType.getFailed);
      const state = PurchaseState(errorType: failure);

      final next = state.copyWith(errorType: null);

      expect(next.errorType, isNull);
    });
  });
}
