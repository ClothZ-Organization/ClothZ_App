import 'package:finding_clothes/src/shared/extension/route_parameters.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/application/view_model.dart';
import '../../../shared/services/presentation_service.dart';
import '../../../shared/utils/constants/routes.dart';

class LoginViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  String errorText = '';
  bool isLoading = false;

  LoginViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
  }

  void login({email = '', password = ''}) async {
    isLoading = true;
    notifyListeners();
    try {
      await _authenticationService.login(email, password);

      await checkVerifiedEmail(email: email, password: password);
    } catch (error) {
      errorText = 'Wrong credentials!';
      isLoading = false;
      notifyListeners();
      debugPrint("Error: ${error.toString()}");
    }
  }

  Future<void> checkVerifiedEmail(
      {required String email, required String password}) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user?.emailVerified ?? false) {
      await _presentationService.push(
        route: Routes.dashboard,
        clearBackStack: true,
      );
    } else {
      await _presentationService.push(
        route: Routes.emailValidation.withParams(
          {
            RouteParameters.email: email,
            RouteParameters.password: password,
          },
        ),
        clearBackStack: true,
      );
    }
  }

  void goRegister() async {
    await _presentationService.push(route: Routes.register);
  }

  void changeText(String a) {
    notifyListeners();
  }

  bool get isErrorLogIn => errorText == '';
}

var loginViewModelProvider =
    ViewModelProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(ref);
});
