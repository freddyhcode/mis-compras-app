class PurchaseItemEntity {
  const PurchaseItemEntity({
    this.id,
    required this.purchaseId,
    required this.name,
    required this.quantityMilli,
    required this.unit,
    required this.unitPriceClp,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int purchaseId;
  final String name;
  final int quantityMilli;
  final String unit;
  final int unitPriceClp;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;

  PurchaseItemEntity copyWith({
    int? id,
    int? purchaseId,
    String? name,
    int? quantityMilli,
    String? unit,
    int? unitPriceClp,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PurchaseItemEntity(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      name: name ?? this.name,
      quantityMilli: quantityMilli ?? this.quantityMilli,
      unit: unit ?? this.unit,
      unitPriceClp: unitPriceClp ?? this.unitPriceClp,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
