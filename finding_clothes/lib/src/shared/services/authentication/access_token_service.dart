import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../storage/storage_service.dart';
import 'authentication_service.dart';

class AccessTokenService {
  final StorageService _storageUtilsService;
  final AuthenticationService _authenticationService;

  AccessTokenService(
    StorageService storageUtilsService,
    AuthenticationService authenticationService
    ) : 
    _storageUtilsService = storageUtilsService, 
    _authenticationService = authenticationService
  ;

  Future<String> get() async {
    final isUserAuthenticated = await _storageUtilsService.isUserAuthenticated();
    if (!isUserAuthenticated) {
      throw Exception("Trying to refresh the token while the user is not authenticated.");
    }

    final hasValidAccessToken = await checkAuthentificationAndTryToRefreshToken();
    if (!hasValidAccessToken) {
      throw Exception("Unable to refresh the access token.");
    }

    return await _storageUtilsService.getUserAccessToken();
  }

  /// Returns `true` if the user is authenticated, `false` if not authenticated or the process
  /// of refreshing the token has failed.
  Future<bool> checkAuthentificationAndTryToRefreshToken() async {
    final isUserAuthenticated = await _storageUtilsService.isUserAuthenticated();

    if (!isUserAuthenticated) {
      return false;
    }

    // Granted there is an authenticate user, check if the access token is still valid
    final accessTokenExpirationDate = await _storageUtilsService.getAccessTokenExpirationDate();
    final millisecondsSince1970Utc = DateTime.now().toUtc().millisecondsSinceEpoch;

    if (accessTokenExpirationDate > millisecondsSince1970Utc) {
      // If the access token is still valid, the user is considered authenticated
      return true;
    }

    print("The access token is expired, attempting to refresh.");

    try {
      // If the access token is present but expired, we try to get and store a new access token
      await _authenticationService.refreshSession();

      // The refresh was successful hence the user is considered as authenticated
      print( "Succesfully refreshed the access token.");
      return true;
    } catch (exception) {
      print( "refresh the access token $exception");
  
      // If we fail to get a new access token then the user is not authenticated
      return false;
    }
  }
}

final accessTokenServiceProvider = Provider((ref) {
  final storageUtilsService = ref.watch(storageServiceProvider);
  final authenticationService = ref.watch(authenticationServiceProvider);
  return AccessTokenService(storageUtilsService, authenticationService);
});
