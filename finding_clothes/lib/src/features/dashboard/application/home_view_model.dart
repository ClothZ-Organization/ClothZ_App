import 'dart:async';

import 'package:finding_clothes/src/app/app_router.gr.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  bool isBookMark = false;
  XFile? image;

  HomeViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
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

    notifyListeners();
    return false;
  }

  void changeScreen() {
    _presentationService.pushRoute(const ResultRoute());
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
