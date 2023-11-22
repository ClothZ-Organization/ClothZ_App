import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finding_clothes/src/shared/services/authentication/access_token_service.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/request_headers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessTokenInterceptor extends Interceptor {
  late final AccessTokenService _accessTokenService;
  // late final PresentationService _presentationService;
  // late final AuthenticationService _authenticationService;

  AccessTokenInterceptor(
    AccessTokenService accessTokenService, 
    PresentationService presentationService,
    AuthenticationService authenticationService
  ) {
    _accessTokenService = accessTokenService;
    // _presentationService = presentationService;
    // _authenticationService = authenticationService;
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = options.headers;

    if (headers.containsKey(RequestsHeaders.authorization)) {
      try {
        final accessToken = await _accessTokenService.get();
        headers[RequestsHeaders.authorization] = "Bearer $accessToken";
      } catch(error) {
        log("[AccessTokenInterceptor] There was an error while trying to refresh the access token");
        // _presentationService.showDialog(
        //   title: TextResources.authorizationErrorTitle, 
        //   message: TextResources.authorizationErrorMessage,
        //   confirmText: TextResources.logOut,
        //   onConfirm: () async {
        //     await _authenticationService.logOut();
        //     await _presentationService.push(route: Routes.login, clearBackStack: true);
        //   },
        //   dismissOnTapOutside: false
        // );
      }
    }

    super.onRequest(options, handler);
  }
}

class RequestHeaders {
}

final accessTokenInterceptorProvider = Provider((ref) {
  final tokenService = ref.watch(accessTokenServiceProvider);
  final presentationService = ref.watch(presentationServiceProvider);
  final authenticationService = ref.watch(authenticationServiceProvider);
  return AccessTokenInterceptor(tokenService, presentationService, authenticationService);  
});