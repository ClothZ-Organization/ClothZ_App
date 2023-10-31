import 'package:finding_clothes/src/app/app_router.gr.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends ViewModel {
  late final PresentationService _presentationService;
  bool isBookMark = false;
  
  HomeViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  void changeScreen() {
    _presentationService.pushRoute(const ResultRoute());
  }

  Future change() async {
    isBookMark = !isBookMark;
    notifyListeners();
  }

  
}

var homeViewModel =
    ViewModelProvider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});