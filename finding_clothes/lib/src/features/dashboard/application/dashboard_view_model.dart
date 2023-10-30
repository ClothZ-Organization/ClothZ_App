import 'package:finding_clothes/src/features/dashboard/presentation/bookmark_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/home_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/scan_page.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/application/view_model.dart';
import '../../../shared/services/presentation_service.dart';

class DashboardViewModel extends ViewModel {
  late final PresentationService _presentationService;
  int currentTab = 0;

  final List<Widget> screens = [
    const HomePage(),
    const ScanPage(),
    const BookmarkPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  DashboardViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
  }

  Future goBack() async {
    bool result = await _presentationService.pop();
    print('****** $result');
  }

  Future logOut() async {
    FirebaseAuth.instance.signOut().then((value) async {
      debugPrint("Sign Out");
      await _presentationService.push(
          route: Routes.login, clearBackStack: true);
    });
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

    print('----- Dashboard disposed');
  }
}

var dashboardViewModelProvider =
    ViewModelProvider.autoDispose<DashboardViewModel>((ref) {
  return DashboardViewModel(ref);
});
