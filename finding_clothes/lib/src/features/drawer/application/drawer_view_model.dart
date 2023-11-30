import 'dart:io';

import 'package:finding_clothes/src/features/drawer/data/storage_data.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/authentication/authentication_service.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DrawerViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final AuthenticationService _authenticationService;
  late final StorageDrawerApi _storageDrawerApi;
  late String imageProfilePath = 'assets/images/profile.jpeg';
  bool isLoading = false;

  DrawerViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _authenticationService = ref.read(authenticationServiceProvider);
    _storageDrawerApi = ref.read(storageDrawerApi);

    getPhoto();
  }

  Future<void> getPhoto() async {
    imageProfilePath = await _storageDrawerApi.getImageUrl();
    notifyListeners();
  }

  String getImagePath() {
    return imageProfilePath;
  }

  Future<bool> setImage() async {
    XFile? imageSelected;
    final ImagePicker picker = ImagePicker();

    try {
      imageSelected = await picker.pickImage(source: ImageSource.gallery);
      isLoading = true;
      notifyListeners();
    } catch (exception) {
      var statusGalery = await Permission.photos.status;
      var statusCamera = await Permission.camera.status;
      if (statusGalery.isDenied || statusCamera.isDenied) {
        return true;
      }
    }
    if (imageSelected != null) {
      // String userId = FirebaseAuth.instance.currentUser!.uid;
      String pathImage =
          await _storageDrawerApi.saveData(file: File(imageSelected.path));
      if (pathImage != '') {
        imageProfilePath = pathImage;
      }
    }
    notifyListeners();
    isLoading = false;
    return false;
  }

  Future logOut() async {
    _authenticationService.logOut();
    await _presentationService.push(route: Routes.login, clearBackStack: true);
  }  
}

var drawerViewModelProvider =
    ViewModelProvider.autoDispose<DrawerViewModel>((ref) {
  return DrawerViewModel(ref);
});
