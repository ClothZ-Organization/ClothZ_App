import 'dart:async';

import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/extension/route_parameters.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  bool isLoading = false;

  bool isNotOkPass = false;
  bool isNotOkEmail = false;
  String? textPasswordIsNotOk;
  String? textEmailIsNotOk;

  RegisterViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
  }

  Future<void> register(
      {email = '', password = '', passwordConfirm = ''}) async {
    isLoading = true;
    notifyListeners();
    if (password == passwordConfirm) {
      isNotOkPass = false;
      textPasswordIsNotOk = null;
      isNotOkEmail = false;
      textEmailIsNotOk = null;
      if (password != '') {
        try {
          await _authenticationService.register(email, password);
          debugPrint("Created New Account");

          await _presentationService.push(
            route: Routes.emailValidation.withParams(
              {
                RouteParameters.email: email,
                RouteParameters.password: password,
              },
            ),
            clearBackStack: true,
          );
        } catch (error) {
          if (error is FirebaseAuthException) {
            if (error.code.contains('email')) {
              isNotOkEmail = true;
              textEmailIsNotOk = error.message;
            }
            if (error.code.contains('password')) {
              isNotOkPass = true;
              textPasswordIsNotOk = error.message;
            }
            notifyListeners();
          }
          isLoading = false;
          notifyListeners();
          debugPrint("Error: ${error.toString()}");
        }
      } else {
        isNotOkPass = true;
        textPasswordIsNotOk = 'Password should be at least 6 characters';

        isLoading = false;
        notifyListeners();
      }
    } else {
      isNotOkPass = true;
      textPasswordIsNotOk = 'Passwords don\'t match';

      isLoading = false;
      notifyListeners();
      debugPrint('Passwords do not match');
    }
  }

  void goLogIn() async {
    await _presentationService.pop();
  }

  void changeTextEmail(String email) {
    notifyListeners();
  }

  void changeTextPass1(String password1) {
    notifyListeners();
  }

  void changeTextPass2(String password2) {
    notifyListeners();
  }
}

var registerViewModelProvider =
    ViewModelProvider.autoDispose<RegisterViewModel>((ref) {
  return RegisterViewModel(ref);
});
