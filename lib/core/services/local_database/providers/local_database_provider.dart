import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/services/local_database/local_database.dart';
import 'package:mis_compras_app/core/services/local_database/local_database_impl.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) {
  return LocalDatabaseImpl();
});
