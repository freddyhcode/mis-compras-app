part of 'purchase_provider.dart';

class PurchaseState {
  const PurchaseState({
    this.purchases = const [],
    this.isLoading = false,
    this.errorType,
  });

  final List<PurchaseEntity> purchases;
  final bool isLoading;
  final Failure? errorType;

  PurchaseState copyWith({
    List<PurchaseEntity>? purchases,
    bool? isLoading,
    Object? errorType = _sentinel,
  }) {
    return PurchaseState(
      purchases: purchases ?? this.purchases,
      isLoading: isLoading ?? this.isLoading,
      errorType: identical(errorType, _sentinel)
          ? this.errorType
          : errorType as Failure?,
    );
  }
}

const _sentinel = Object();
