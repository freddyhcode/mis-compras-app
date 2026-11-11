import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mis_compras_app/core/services/share/share_service.dart';
import 'package:share_plus/share_plus.dart';

class ShareServiceImpl implements ShareService {
  @override
  Future<AppShareResult> shareText({
    required String title,
    required String text,
  }) async {
    if (kIsWeb) {
      try {
        final result = await SharePlus.instance.share(
          ShareParams(title: title, text: text),
        );

        if (result.status == ShareResultStatus.dismissed) {
          return AppShareResult.cancelled;
        }
        if (result.status == ShareResultStatus.success) {
          return AppShareResult.shared;
        }
      } catch (_) {
        // Si el navegador no puede compartir, se copia al portapapeles.
      }

      await Clipboard.setData(ClipboardData(text: text));
      return AppShareResult.copied;
    }

    final result = await SharePlus.instance.share(
      ShareParams(title: title, text: text),
    );

    if (result.status == ShareResultStatus.dismissed) {
      return AppShareResult.cancelled;
    }

    return AppShareResult.shared;
  }
}
