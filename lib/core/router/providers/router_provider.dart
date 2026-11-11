import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage_impl.dart';

part 'router_state.dart';
part 'router_notifier.dart';

final routerProvider = NotifierProvider<RouterNotifier, RouterState>(
  RouterNotifier.new,
);
