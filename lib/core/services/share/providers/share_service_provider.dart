import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/services/share/share_service.dart';
import 'package:mis_compras_app/core/services/share/share_service_impl.dart';

final shareServiceProvider = Provider<ShareService>((ref) {
  return ShareServiceImpl();
});
