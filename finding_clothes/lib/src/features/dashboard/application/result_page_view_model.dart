import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultPageViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  ResultPageViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
  }

  String imagePath(){
    String path = _dashboardViewModel.image?.path ?? 'assets/images/register_img.png'; // TODO: must be modified
    return path;
  }
}

var resultPageViewModel = ViewModelProvider.autoDispose<ResultPageViewModel>((ref) {
  return ResultPageViewModel(ref);
});
