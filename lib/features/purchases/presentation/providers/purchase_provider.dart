import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/errors/database_error_type.dart';
import 'package:mis_compras_app/core/errors/either.dart';
import 'package:mis_compras_app/core/errors/failure.dart';
import 'package:mis_compras_app/core/utils/text.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/entities/purchase_item_entity.dart';
import 'package:mis_compras_app/features/purchases/domain/repositories/purchase_repository.dart';
import 'package:mis_compras_app/core/l10n/app_localizations.dart';
import 'package:mis_compras_app/core/services/files/providers/file_saver_provider.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_export.dart';
import 'package:mis_compras_app/features/purchases/presentation/utils/purchase_seeder.dart';

import 'package:mis_compras_app/features/purchases/infrastructure/repositories/purchase_repository_impl.dart';

part 'purchase_state.dart';
part 'purchase_notifier.dart';

final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  return PurchaseRepositoryImpl();
});

final purchaseProvider = NotifierProvider<PurchaseNotifier, PurchaseState>(
  PurchaseNotifier.new,
);
