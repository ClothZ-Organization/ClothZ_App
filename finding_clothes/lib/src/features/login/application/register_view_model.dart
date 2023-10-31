import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  bool isLoading = false;

  RegisterViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
  }

  void register({email = '', password = '', passwordConfirm = ''}) async {
    isLoading = true;
    notifyListeners();
    if (password == passwordConfirm) {
      try {
        await _authenticationService.register(email, password);
        debugPrint("Created New Account");

        await _authenticationService.login(email, password);
        debugPrint("Logged in New Account");

        await _presentationService.push(
            route: Routes.dashboard, clearBackStack: true);
      } catch (error) {
        isLoading = false;
        notifyListeners();
        debugPrint("Error: ${error.toString()}");
      }
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
