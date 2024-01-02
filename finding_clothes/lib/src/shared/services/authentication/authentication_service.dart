import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/storage_service.dart';

class AuthenticationService {
  late final StorageService _storageService;

  AuthenticationService(ProviderRef providerRef) {
    _storageService = providerRef.read(storageServiceProvider);
  }
  Future register(email, password) async {
    log("[Register] Register operation started!");

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (error) {
      rethrow;
    }

    log("Registered in successfuly!");
  }

  Future login(email, password) async {
    log("[Login] Login operation started!");

    try {
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveToken(result);
    } catch (error) {
      rethrow;
    }

    log("Logged in successfuly!");
  }

  Future _saveToken(UserCredential result) async {
    try {
      String token = await result.user?.getIdToken() ?? '';
      IdTokenResult? tokenResult = await result.user?.getIdTokenResult();
      DateTime? expirationTime = tokenResult?.expirationTime;
      String? refreshToken = result.user?.refreshToken;

      if (token != '' && expirationTime != null && refreshToken != null) {
        await _storageService.setUserAccessToken(token);
        await _storageService.setTokenExpirationDate(expirationTime);
        await _storageService.setUserRefreshToken(refreshToken);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future loginWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      UserCredential result =
          await FirebaseAuth.instance.signInWithProvider(googleAuthProvider);
      await _saveToken(result);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future refreshSession() async {
    log("Tokens successfuly refreshed!");
  }

  Future logOut() async {
    await _storageService.removeUserData();
    log("Successfuly logged out!");
  }

  Future deleteAccount(User? user) async {
    try {
      if (user != null) {
        await user.delete();
        debugPrint('Account deleted successfully!');
      } else {
        debugPrint('There is not logged in.');
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      debugPrint('--- Exception FirebaseAuthException');
      rethrow;
      // if (e.code == "requires-recent-login") {
      //   // await _reauthenticateAndDelete();
      // } else {
      //   // Handle other Firebase exceptions
      // }
    } catch (e) {
      log(e.toString());
      debugPrint('--- Exception catch');
      rethrow;
    }
  }
}

var authenticationServiceProvider = Provider((ref) {
  return AuthenticationService(ref);
});
