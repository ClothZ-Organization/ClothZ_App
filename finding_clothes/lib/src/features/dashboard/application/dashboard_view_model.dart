import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/application/view_model.dart';
import '../../../shared/services/presentation_service.dart';

class DashboardViewModel extends ViewModel {
  late final PresentationService _presentationService;

  DashboardViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  Future goBack() async {
    bool result = await _presentationService.pop();
    print('****** $result');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print('----- Dashboard disposed');
  }
}

var dashboardViewModelProvider =
    ViewModelProvider.autoDispose<DashboardViewModel>((ref) {
  return DashboardViewModel(ref);
});
