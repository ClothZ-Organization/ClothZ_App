import 'dart:async';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/features/dashboard/domain/search_list.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final DashboardViewModel _dashboardViewModel;
  late final FirebaseApi _firebaseApi;
  bool isBookMark = false;
  int counter = 0;

  HomeViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _firebaseApi = ref.read(firebaseApi);
    getCounter();
    getSearchList();
  }

  Future<void> getCounter() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    int response = await _firebaseApi.getCounter(userId);
    if (response >= 0) {
      counter = response;
      notifyListeners();
    }
  }

  Future<void> getSearchList() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<SearchListModel> response = await _firebaseApi.getSearchList(userId);
    if (response.isNotEmpty) {
      _dashboardViewModel.searchList = response;
      notifyListeners();
    } else {
      _firebaseApi.addInitialSearchList(userId, _dashboardViewModel.searchList);
    }
  }

  String getImageCard(int index) {
    return _dashboardViewModel.searchList[index].imageUrl;
  }
  int sizeSearchList() {
    return _dashboardViewModel.searchList.length;
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
