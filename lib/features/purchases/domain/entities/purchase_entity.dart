import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';

class PurchaseEntity {
  const PurchaseEntity({
    this.id,
    required this.title,
    required this.purchasedAt,
    this.merchant,
    this.category,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
  });

  static const Object _unset = Object();

  final int? id;
  final String title;
  final String purchasedAt;
  final String? merchant;
  final String? category;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PurchaseItemEntity> items;

  PurchaseEntity copyWith({
    int? id,
    String? title,
    String? purchasedAt,
    Object? merchant = _unset,
    Object? category = _unset,
    Object? notes = _unset,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<PurchaseItemEntity>? items,
  }) {
    return PurchaseEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      merchant: identical(merchant, _unset)
          ? this.merchant
          : merchant as String?,
      category: identical(category, _unset)
          ? this.category
          : category as String?,
      notes: identical(notes, _unset) ? this.notes : notes as String?,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }
}
