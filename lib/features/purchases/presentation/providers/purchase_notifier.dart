part of 'purchase_provider.dart';

class PurchaseNotifier extends Notifier<PurchaseState> {
  late final PurchaseRepository _repository;

  @override
  PurchaseState build() {
    _repository = ref.read(purchaseRepositoryProvider);
    Future.microtask(loadPurchases);
    return const PurchaseState(isLoading: true);
  }

  PurchaseRepository _ready() {
    return _repository;
  }

  Future<void> loadPurchases() async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = _repository;
      final result = await repository.getAll();

      result.fold(
        (failure) {
          state = state.copyWith(isLoading: false, errorType: failure);
        },
        (purchases) {
          state = state.copyWith(
            purchases: purchases,
            isLoading: false,
            errorType: null,
          );
        },
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorType: const DatabaseFailure(DatabaseErrorType.getFailed),
      );
    }
  }

  Future<Either<Failure, PurchaseEntity>> createPurchase({
    required String title,
    required String purchasedAt,
    String? merchant,
    String? category,
    String? notes,
  }) async {
    final now = DateTime.now();
    final purchase = PurchaseEntity(
      title: normalizeText(title),
      purchasedAt: purchasedAt,
      merchant: normalizeNullableText(merchant),
      category: category,
      notes: normalizeNullableText(notes),
      createdAt: now,
      updatedAt: now,
    );

    final repository = _repository;
    final result = await repository.insert(purchase);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorType: failure);
      },
      (created) {
        _upsert(created);
      },
    );

    return result;
  }

  Future<Either<Failure, PurchaseEntity>> updatePurchase(
    PurchaseEntity purchase, {
    required String title,
    required String purchasedAt,
    String? merchant,
    String? category,
    String? notes,
  }) async {
    final updated = purchase.copyWith(
      title: normalizeText(title),
      purchasedAt: purchasedAt,
      merchant: normalizeNullableText(merchant),
      category: category,
      notes: normalizeNullableText(notes),
      updatedAt: DateTime.now(),
    );

    final repository = _repository;
    final result = await repository.update(updated);

    result.fold(
      (failure) {
        state = state.copyWith(errorType: failure);
      },
      (saved) {
        _upsert(saved);
      },
    );

    return result;
  }

  Future<Either<Failure, bool>> deletePurchase(int id) async {
    final repository = _repository;
    final result = await repository.delete(id);

    result.fold(
      (failure) {
        state = state.copyWith(errorType: failure);
      },
      (deleted) {
        if (!deleted) {
          state = state.copyWith(isLoading: false);
          return;
        }

        state = state.copyWith(
          purchases: state.purchases
              .where((purchase) => purchase.id != id)
              .toList(),
          isLoading: false,
          errorType: null,
        );
      },
    );

    return result;
  }

  Future<List<PurchaseEntity>> purchasesForExport() async {
    _ready();

    if (state.purchases.isEmpty && !state.isLoading) {
      await loadPurchases();
    }

    return state.purchases;
  }

  Future<bool> exportData(AppLocalizations l10n) async {
    try {
      final purchases = await purchasesForExport();
      await exportPurchasesToXlsx(
        purchases: purchases,
        l10n: l10n,
        fileSaver: ref.read(fileSaverProvider),
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<int?> seedData() async {
    final seeds = buildSeedPurchases();

    for (final seed in seeds) {
      PurchaseEntity? purchase;

      final createResult = await createPurchase(
        title: seed.title,
        purchasedAt: seed.purchasedAt,
        merchant: seed.merchant,
        category: seed.category,
        notes: seed.notes,
      );

      createResult.fold((failure) {}, (created) {
        purchase = created;
      });

      if (purchase?.id == null) return null;

      for (final product in seed.products) {
        var added = true;

        final itemResult = await addItem(
          purchaseId: purchase!.id!,
          name: product.name,
          quantityMilli: product.quantityMilli,
          unit: product.unit,
          unitPriceClp: product.unitPriceClp,
        );

        itemResult.fold((failure) {
          added = false;
        }, (saved) {});

        if (!added) return null;
      }
    }

    return seeds.length;
  }

  Future<Either<Failure, bool>> resetAll() async {
    final repository = _ready();
    final result = await repository.clearAll();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorType: failure);
      },
      (cleared) {
        if (cleared) {
          state = const PurchaseState();
        }
      },
    );

    return result;
  }

  Future<Either<Failure, PurchaseEntity>> duplicatePurchase(
    int id, {
    required String suffix,
  }) async {
    final repository = _ready();
    final result = await repository.duplicate(id, suffix);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorType: failure);
      },
      (saved) {
        _upsert(saved);
      },
    );

    return result;
  }

  Future<Either<Failure, PurchaseEntity>> addItem({
    required int purchaseId,
    required String name,
    required int quantityMilli,
    required String unit,
    required int unitPriceClp,
  }) async {
    final now = DateTime.now();
    final item = PurchaseItemEntity(
      purchaseId: purchaseId,
      name: normalizeText(name),
      quantityMilli: quantityMilli,
      unit: unit,
      unitPriceClp: unitPriceClp,
      position: 0,
      createdAt: now,
      updatedAt: now,
    );

    final repository = _repository;
    final result = await repository.addItem(purchaseId, item);

    result.fold(
      (failure) {
        state = state.copyWith(errorType: failure);
      },
      (saved) {
        _upsert(saved);
      },
    );

    return result;
  }

  Future<Either<Failure, PurchaseEntity>> updateItem(
    PurchaseItemEntity item, {
    required String name,
    required int quantityMilli,
    required String unit,
    required int unitPriceClp,
  }) async {
    final updated = item.copyWith(
      name: normalizeText(name),
      quantityMilli: quantityMilli,
      unit: unit,
      unitPriceClp: unitPriceClp,
      updatedAt: DateTime.now(),
    );

    final repository = _repository;
    final result = await repository.updateItem(item.purchaseId, updated);

    result.fold(
      (failure) {
        state = state.copyWith(errorType: failure);
      },
      (saved) {
        _upsert(saved);
      },
    );

    return result;
  }

  Future<Either<Failure, PurchaseEntity>> removeItem(
    int purchaseId,
    int itemId,
  ) async {
    final repository = _repository;
    final result = await repository.removeItem(purchaseId, itemId);

    result.fold(
      (failure) {
        state = state.copyWith(errorType: failure);
      },
      (saved) {
        _upsert(saved);
      },
    );

    return result;
  }

  void _upsert(PurchaseEntity purchase) {
    final purchases = [...state.purchases];
    final index = purchases.indexWhere((item) => item.id == purchase.id);

    if (index == -1) {
      purchases.add(purchase);
    } else {
      purchases[index] = purchase;
    }

    purchases.sort(_byDateDesc);

    state = state.copyWith(
      purchases: purchases,
      isLoading: false,
      errorType: null,
    );
  }

  int _byDateDesc(PurchaseEntity a, PurchaseEntity b) {
    final byDate = b.purchasedAt.compareTo(a.purchasedAt);
    return byDate != 0 ? byDate : b.createdAt.compareTo(a.createdAt);
  }
}
