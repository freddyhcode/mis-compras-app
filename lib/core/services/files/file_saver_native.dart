import 'dart:io';

import 'package:mis_compras_app/core/services/files/file_saver.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileSaverImpl implements FileSaver {
  @override
  Future<void> save({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
    required String title,
  }) async {
    final directory = await getTemporaryDirectory();
    final path = join(directory.path, fileName);
    await File(path).writeAsBytes(bytes, flush: true);

    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(path, mimeType: mimeType)],
        subject: title,
      ),
    );
  }
}
