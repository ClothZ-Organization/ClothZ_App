import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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

  Future logOut() async {
    FirebaseAuth.instance.signOut().then((value) async {
      debugPrint("Sign Out");
      await _presentationService.push(
          route: Routes.login, clearBackStack: true);
    });
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
