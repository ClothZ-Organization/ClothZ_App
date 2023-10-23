
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  late final FlutterSecureStorage _storage;

  SecureStorage(FlutterSecureStorage flutterSecureStorage) {
    _storage = flutterSecureStorage;
  }

  Future setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getStringOrNullIfAbsent(String key) async {
    return await _storage.read(key: key);
  }

  Future<String> getString(String key) async {
    final stringValue = await _storage.read(key: key);
    
    if(stringValue == null) {
      throw Exception("No string value found for key: $key");
    }

    return stringValue;
  }

  Future setInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<int?> getIntOrNullIfAbsent(String key) async {
    final intValue = await _storage.read(key: key);

    if(intValue == null) {
      return null;
    } 

    return int.parse(intValue);
  }

  Future<int> getInt(String key) async  {
    final intValue = await _storage.read(key: key);
    
    if(intValue == null) {
      throw Exception("No int value found for key: $key");
    }

    return int.parse(intValue);
  }

  Future removeKey(String key) async {
    await _storage.delete(key: key);
  }

  Future clearStorage() async {
    await _storage.deleteAll();
  }

  Future readAllKeys() async {
    await _storage.readAll();
  }
}

var secureStorageProvider = Provider((ref) {
  const flutterSecureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
    )
  );
  
  return SecureStorage(flutterSecureStorage);
});