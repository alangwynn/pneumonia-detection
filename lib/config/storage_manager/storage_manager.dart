class StorageManager {
  /// Singleton
  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal() {
    _storage = {};
  }

  Map<String, String>? _storage;

  /// Singleton
  static final StorageManager _instance = StorageManager._internal();

  /// setString.
  Future<void> setString({required String key, required String value}) async {
    _storage?.addAll({key: value});
  }

  /// getString.
  Future<String?> getString({required String key}) async {
    return _storage?[key];
  }

  /// clear
  Future<void> clear() async {
    return _storage = null;
  }
}