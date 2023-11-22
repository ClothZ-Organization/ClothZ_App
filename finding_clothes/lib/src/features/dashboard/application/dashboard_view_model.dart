import 'package:finding_clothes/src/features/dashboard/domain/list_result.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/bookmark_presentation/bookmark_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/home_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/result_presentation/result_page.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/application/view_model.dart';
import '../../../shared/services/presentation_service.dart';

class DashboardViewModel extends ViewModel {
  late final PresentationService _presentationService;
  int currentTab = 0;
  XFile? image;
  ListResultModel? resultModel;

  late List<Widget> screens;

  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen;

  DashboardViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);

    screens = [
      const HomePage(),
      const ResultPage(),
      const BookmarkPage(),
    ];

    currentScreen = const HomePage();
  }

  Future goBack() async {
    bool result = await _presentationService.pop();
    debugPrint('****** $result');
  }

  Future logOut() async {
    FirebaseAuth.instance.signOut().then((value) async {
      debugPrint("Sign Out");
      await _presentationService.push(
          route: Routes.login, clearBackStack: true);
    });
  }

  Future setImage(XFile? imageF) async {
    image = imageF;
  }

  bool isThis(int index) {
    return currentTab == index;
  }

  Future setTab(int index) async {
    currentTab = index;
    currentScreen = screens[currentTab];
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    debugPrint('----- Dashboard disposed');
  }
}

var dashboardViewModelProvider =
    ViewModelProvider.autoDispose<DashboardViewModel>((ref) {
  return DashboardViewModel(ref);
});
