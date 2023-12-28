import 'dart:developer';

import 'package:finding_clothes/src/shared/services/storage/secure_storage.dart';
import 'package:finding_clothes/src/shared/services/storage/shared_preferences_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/constants/storage_constants.dart';

class StorageService {
  late final SecureStorage _secureStorage;
  late final SharedPreferencesStorage _sharedPreferencesStorage;

  StorageService(SecureStorage secureStorage,
      SharedPreferencesStorage sharedPreferencesStorage) {
    _secureStorage = secureStorage;
    _sharedPreferencesStorage = sharedPreferencesStorage;
  }

  void setAppWasPeviouslyLanched() {
    _sharedPreferencesStorage.setBool(
        StorageConstants.appWasPreviouslyLaunched, true);
  }

  bool appWasPreviouslyLaunched() {
    return _sharedPreferencesStorage
        .readBool(StorageConstants.appWasPreviouslyLaunched, ifAbsent: false);
  }

  Future<bool> isUserAuthenticated() async {
    return await _secureStorage
            .getStringOrNullIfAbsent(StorageConstants.accessTokenKey) !=
        null;
  }

  Future<String> getUserAccessToken() async {
    return await _secureStorage.getString(StorageConstants.accessTokenKey);
  }

  Future<String> getUserRefreshToken() async {
    return await _secureStorage.getString(StorageConstants.refreshTokenKey);
  }

  Future setUserRefreshToken(String token) async {
    await _secureStorage.setString(StorageConstants.refreshTokenKey, token);
  }

  ///
  Future setUserAccessToken(String token) async {
    await _secureStorage.setString(StorageConstants.accessTokenKey, token);
  }

  Future setTokenExpirationDate(DateTime dateTimeExpirationDate) async {
    int value = dateTimeExpirationDate.millisecondsSinceEpoch;
    await _secureStorage.setInt(
        StorageConstants.accessTokenExpirationDateKey, value);
  }

  ///

  Future removeUserData() async {
    await _secureStorage.removeKey(StorageConstants.accessTokenKey);
    await _secureStorage.removeKey(StorageConstants.refreshTokenKey);
    await _secureStorage.removeKey(StorageConstants.accessTokenExpirationDateKey);
  }

  Future cleanAll() async {
    await _secureStorage.clearStorage();
    await _sharedPreferencesStorage.clearStorage();

    log("[StorageService] All stored data has been removed.");
  }

  Future<int> getAccessTokenExpirationDate() async {
    return await _secureStorage
        .getInt(StorageConstants.accessTokenExpirationDateKey);
  }
}

var storageServiceProvider = Provider((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  final sharedPreferencesStorage = ref.watch(sharedPreferencesStorageProvider);
  return StorageService(secureStorage, sharedPreferencesStorage);
});
