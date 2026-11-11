import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';

class PurchaseItemMapper {
  const PurchaseItemMapper._();

  static PurchaseItemEntity fromMap(Map<String, Object?> map) {
    return PurchaseItemEntity(
      id: map['id'] as int?,
      purchaseId: map['purchase_id'] as int,
      name: normalizeText(map['name'] as String),
      quantityMilli: map['quantity_milli'] as int,
      unit: map['unit'] as String,
      unitPriceClp: map['unit_price_clp'] as int,
      position: map['position'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  static Map<String, Object?> toMap(PurchaseItemEntity item) {
    return {
      'id': item.id,
      'purchase_id': item.purchaseId,
      'name': normalizeText(item.name),
      'quantity_milli': item.quantityMilli,
      'unit': item.unit,
      'unit_price_clp': item.unitPriceClp,
      'position': item.position,
      'created_at': item.createdAt.toIso8601String(),
      'updated_at': item.updatedAt.toIso8601String(),
    };
  }
}
