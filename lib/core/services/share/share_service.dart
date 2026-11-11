enum AppShareResult { shared, copied, cancelled }

abstract class ShareService {
  Future<AppShareResult> shareText({
    required String title,
    required String text,
  });
}
