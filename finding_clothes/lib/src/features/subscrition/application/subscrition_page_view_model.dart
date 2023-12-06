import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscritionPlanViewModel extends ViewModel {
  late final PresentationService _presentationService;
  int numberSelected = 1;

  SubscritionPlanViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  bool isSelected(int number) {
    return numberSelected == number;
  }

  void setPlan(int number) {
    numberSelected = number;
    notifyListeners();
  }

  void goBack() {
    _presentationService.pop();
  }
}

var subscritionPlanViewModel =
    ViewModelProvider.autoDispose<SubscritionPlanViewModel>((ref) {
  return SubscritionPlanViewModel(ref);
});
