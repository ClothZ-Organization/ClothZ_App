import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/exceptions/provider_unimplemented_exception.dart';



class SharedPreferencesStorage {
  late final SharedPreferences _preferences;

  SharedPreferencesStorage(SharedPreferences preferences) {
    _preferences = preferences;
  }

  String readString(String key) {
    final stringValue = _preferences.getString(key);

    if(stringValue == null) {
      throw Exception("No string value found for key: $key");
    }

    return stringValue;
  }

   String? readStringOrNull(String key) {
    final stringValue = _preferences.getString(key);
    return stringValue;
  }

  void writeString(String key, String value) {
    _preferences.setString(key, value);
  } 

  int readInt(String key) {
    final intValue = _preferences.getInt(key);
    if(intValue == null) {
      throw Exception("No string value found for key: $key");
    }

    return intValue;
  }

  void writeInt(String key, int value) {
    _preferences.setInt(key, value);
  } 

  bool readBool(String key, { bool ifAbsent = false }) {
    return _preferences.getBool(key) ?? ifAbsent;
  }

  void setBool(String key, bool value) {
    _preferences.setBool(key, value);
  }

  void removeValueFor({required String key}) {
    _preferences.remove(key);
  }

  Future<bool> clearStorage() async {
    return await _preferences.clear();
  }
}

var sharedPreferencesStorageProvider = Provider<SharedPreferencesStorage>((ref) {
  throw ProviderNotImplementedException(serviceName: (SharedPreferencesStorage).toString());
});