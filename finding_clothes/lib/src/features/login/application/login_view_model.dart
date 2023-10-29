import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/application/view_model.dart';
import '../../../shared/services/presentation_service.dart';
import '../../../shared/utils/constants/routes.dart';

class LoginViewModel extends ViewModel {
  late final PresentationService _presentationService;
  bool isLoading = false;

  LoginViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  void login({email = '', password = ''}) async {
    isLoading = true;
    notifyListeners();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await _presentationService.push(
          route: Routes.dashboard, clearBackStack: true);
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
      debugPrint("Error ${error.toString()}");
    });
  }

  void goRegister() async {
    await _presentationService.push(route: Routes.register);
  }

  void changeText(String a) {
    notifyListeners();
  }
}

var loginViewModelProvider =
    ViewModelProvider.autoDispose<LoginViewModel>((ref) {
  return LoginViewModel(ref);
});
