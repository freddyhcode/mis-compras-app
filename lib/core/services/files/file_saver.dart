abstract class FileSaver {
  Future<void> save({
    required String fileName,
    required List<int> bytes,
    required String mimeType,
    required String title,
  });
}
