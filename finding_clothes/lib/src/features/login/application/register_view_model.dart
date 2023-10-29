import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViewModel extends ViewModel {
  late final PresentationService _presentationService;
  bool isLoading = false;

  RegisterViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  void register({email = '', password = '', passwordConfirm = ''}) async {
    isLoading = true;
    notifyListeners();
    if (password == passwordConfirm) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        debugPrint("Created New Account");
        await _presentationService.push(
            route: Routes.dashboard, clearBackStack: true);
      }).onError((error, stackTrace) {
        isLoading = false;
        notifyListeners();
        debugPrint("Error ${error.toString()}");
      });
    } else {
      isLoading = false;
      notifyListeners();
      debugPrint('Passwords do not match');
    }
  }

  void goLogIn() async {
    await _presentationService.pop();
  }

  void changeText(String a) {
    notifyListeners();
  }
}

var registerViewModelProvider =
    ViewModelProvider.autoDispose<RegisterViewModel>((ref) {
  return RegisterViewModel(ref);
});
