abstract class WrapperSecureStorage {
  Future<T?> getKeyValue<T>(String key);

  Future<bool> removeKey(String key);

  Future<void> setKeyValue<T>(String key, T value);
}
