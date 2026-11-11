// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

import 'package:mis_compras_app/core/services/files/file_saver.dart';

class FileSaverImpl implements FileSaver {
  @override
  Future<void> save({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
    required String title,
  }) async {
    final blob = html.Blob([bytes], mimeType);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..download = fileName
      ..style.display = 'none';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(url);
  }
}
