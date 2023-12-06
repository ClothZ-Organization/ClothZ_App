import 'dart:async';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  late final DashboardViewModel _dashboardViewModel;
  late final FirebaseApi _firebaseApi;
  bool isBookMark = false;
  int counter = 0;

  HomeViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _firebaseApi = ref.read(firebaseApi);
    getCounter();
  }

  Future<void> getCounter() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    int response = await _firebaseApi.getCounter(userId);
    if (response >= 0) {
      counter = response;
      notifyListeners();
    }
  }

  void clickScanCard() {
    _dashboardViewModel.setTab(1);
  }

  Future change() async {
    isBookMark = !isBookMark;
    notifyListeners();
  }

  void goSubscritionPage() {
    _presentationService.push(route: Routes.subscrition);
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();

  //   debugPrint('----- Home disposed');
  // }
}

var homeViewModel = ViewModelProvider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});
