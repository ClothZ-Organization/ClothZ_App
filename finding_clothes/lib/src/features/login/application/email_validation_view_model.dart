import 'dart:async';

import 'package:finding_clothes/src/features/drawer/data/remove_data_firebase.dart';
import 'package:finding_clothes/src/features/login/domain/login_model.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailValidationViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  late final RemoveDataFirebase _removeDataFirebase;

  late LoginModel loginModel;

  EmailValidationViewModel(Ref ref, this.loginModel) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
    _removeDataFirebase = ref.read(removeDataFirebaseApi);
    init();
  }
  Future<void> init() async {
    await sendEmailVerification();
    await setTimerForAutoRedirect();
  }

  Future<void> sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> setTimerForAutoRedirect() async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          try {
            await _authenticationService.login(
                loginModel.email, loginModel.password);

            await _presentationService.push(
                route: Routes.dashboard, clearBackStack: true);
          } catch (error) {
            rethrow;
          }
        }
      },
    );
  }

  Future<void> backAction() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await _authenticationService
          .deleteAccount(FirebaseAuth.instance.currentUser);
      await _removeDataFirebase.removeAllUser(userId);
      await _presentationService.push(
          route: Routes.login, clearBackStack: true);
    } catch (error) {
      rethrow;
    }
  }

  String getEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '';
  }
}

var emailValidationViewModel = ViewModelProvider.autoDispose
    .family<EmailValidationViewModel, LoginModel>((ref, loginModel) {
  return EmailValidationViewModel(ref, loginModel);
});
