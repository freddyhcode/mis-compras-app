import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mis_compras_app/core/services/files/file_saver.dart';
import 'package:mis_compras_app/core/services/files/file_saver_native.dart'
    if (dart.library.js_interop) 'package:mis_compras_app/core/services/files/file_saver_web.dart';

final fileSaverProvider = Provider<FileSaver>((ref) {
  return FileSaverImpl();
});
