import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterViewModel extends ViewModel {
  late final PresentationService _presentationService;

  RegisterViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  void register() async {
    debugPrint('Register Action');
    // await _presentationService.push(
    //     route: Routes.dashboard);
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
