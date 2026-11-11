import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/infrastructure/mappers/purchase_item_mapper.dart';

class PurchaseMapper {
  const PurchaseMapper._();

  static PurchaseEntity fromMap(
    Map<String, Object?> map, {
    List<PurchaseItemEntity> items = const [],
  }) {
    return PurchaseEntity(
      id: map['id'] as int?,
      title: normalizeText(map['title'] as String),
      purchasedAt: map['purchased_at'] as String,
      merchant: normalizeNullableText(map['merchant'] as String?),
      category: map['category'] as String?,
      notes: normalizeNullableText(map['notes'] as String?),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      items: items,
    );
  }

  static PurchaseEntity fromJson(Map<String, Object?> map) {
    final rawItems = map['items'];
    final items = rawItems is List
        ? rawItems
              .map(
                (item) => PurchaseItemMapper.fromMap(
                  Map<String, Object?>.from(item as Map),
                ),
              )
              .toList()
        : const <PurchaseItemEntity>[];

    return fromMap(map, items: items);
  }

  static Map<String, Object?> toMap(PurchaseEntity purchase) {
    return {
      'id': purchase.id,
      'title': normalizeText(purchase.title),
      'purchased_at': purchase.purchasedAt,
      'merchant': normalizeNullableText(purchase.merchant),
      'category': purchase.category,
      'notes': normalizeNullableText(purchase.notes),
      'created_at': purchase.createdAt.toIso8601String(),
      'updated_at': purchase.updatedAt.toIso8601String(),
    };
  }

  static Map<String, Object?> toJson(PurchaseEntity purchase) {
    return {
      ...toMap(purchase),
      'items': purchase.items.map(PurchaseItemMapper.toMap).toList(),
    };
  }
}
