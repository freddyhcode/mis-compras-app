import 'package:flutter_test/flutter_test.dart';
import 'package:mis_compras_app/features/purchases/infrastructure/mappers/purchase_mapper.dart';

void main() {
  group('PurchaseMapper', () {
    test('convierte una fila y recorta los textos sin cambiar mayúsculas', () {
      final purchase = PurchaseMapper.fromMap({
        'id': 4,
        'title': '  Compra Online  ',
        'purchased_at': '2026-10-12',
        'merchant': '  Lider  ',
        'category': 'supermercado',
        'notes': '  ',
        'created_at': '2026-10-12T10:00:00.000',
        'updated_at': '2026-10-12T11:00:00.000',
      });

      expect(purchase.id, 4);
      expect(purchase.title, 'Compra Online');
      expect(purchase.merchant, 'Lider');
      expect(purchase.notes, isNull);
      expect(purchase.purchasedAt, '2026-10-12');
    });

    test('convierte una entidad en fila conservando las fechas', () {
      final purchase = PurchaseMapper.fromMap({
        'id': 4,
        'title': 'Compra',
        'purchased_at': '2026-10-12',
        'merchant': null,
        'category': null,
        'notes': null,
        'created_at': '2026-10-12T10:00:00.000',
        'updated_at': '2026-10-12T10:00:00.000',
      });

      final map = PurchaseMapper.toMap(purchase);

      expect(map['id'], 4);
      expect(map['title'], 'Compra');
      expect(map['purchased_at'], '2026-10-12');
      expect(map['created_at'], '2026-10-12T10:00:00.000');
    });
  });
}
