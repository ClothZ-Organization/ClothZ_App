import 'dart:async';
import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  late final DashboardViewModel _dashboardViewModel;
  late final FirebaseApi _firebaseApi;
  bool isBookMark = false;
  XFile? image;
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
    if(response < 0) {
      _firebaseApi.addUserCounter(userId, counter);
    } else {
      counter = response;
      notifyListeners();
    }
  }

  Future<bool> getImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    try {
      if (isCamera) {
        image = await picker.pickImage(source: ImageSource.camera);
      } else {
        image = await picker.pickImage(source: ImageSource.gallery);
      }
    } catch (exception) {
      var statusGalery = await Permission.photos.status;
      var statusCamera = await Permission.camera.status;
      if (statusGalery.isDenied || statusCamera.isDenied) {
        return true;
      }
    }
    if (image != null) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      _dashboardViewModel.setImage(image);
      _dashboardViewModel.setTab(1);
      _firebaseApi.counterIncrement(userId);
    }
    return false;
  }

  Future logOut() async {
    _authenticationService.logOut();
    await _presentationService.push(route: Routes.login, clearBackStack: true);
  }

  Future change() async {
    isBookMark = !isBookMark;
    notifyListeners();
  }
}

var homeViewModel = ViewModelProvider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});
