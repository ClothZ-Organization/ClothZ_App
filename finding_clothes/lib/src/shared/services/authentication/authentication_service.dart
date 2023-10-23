import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storage_service.dart';


class AuthenticationService {
  late final StorageService _storageService;

  AuthenticationService(ProviderRef providerRef) {

    _storageService = providerRef.read(storageServiceProvider);

  }

  Future login() async {
    log("[Login] Login operation started!");
   

    log("Logged in successfuly!");
  }

  Future refreshSession() async {

    log("Tokens successfuly refreshed!");
  }

  Future logOut() async {
   
    await _storageService.removeUserData();
    log("Successfuly logged out!");
  }
}

var authenticationServiceProvider = Provider((ref) {
  return AuthenticationService(ref);
});
