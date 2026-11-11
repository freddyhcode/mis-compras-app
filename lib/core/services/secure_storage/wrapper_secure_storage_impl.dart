import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mis_compras_app/core/services/secure_storage/wrapper_secure_storage.dart';

class WrapperSecureStorageImpl implements WrapperSecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<T?> getKeyValue<T>(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;

    switch (T) {
      case const (String):
        return value as T;
      case const (int):
        return int.tryParse(value) as T?;
      case const (double):
        return double.tryParse(value) as T?;
      case const (bool):
        if (value == 'true') return true as T;
        if (value == 'false') return false as T;
        return null;
      default:
        throw UnsupportedError('Type $T is not supported.');
    }
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<bool> removeKey(String key) async {
    try {
      await _storage.delete(key: key);
      return true;
    } catch (_) {
      return false;
    }
  }
}
