import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:finding_clothes/src/shared/services/storage/storage_service.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPageViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  late final FirebaseApi _firebaseApi;
  late final StorageService _storageService;
  late final PresentationService _presentationService;
  String textMessage = 'No scanned products yet';
  late XFile? picture;

  CameraPageViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _firebaseApi = ref.read(firebaseApi);
    _storageService = ref.read(storageServiceProvider);
    _presentationService = ref.read(presentationServiceProvider);
    picture = _dashboardViewModel.image;
  }
  bool isCameraScanPage() {
    return _dashboardViewModel.pageNumberResult == 1;
  }

  bool isNotOkSearch() {
    int counterStorage =  _storageService.getCounter();
    if (counterStorage == -1 && _dashboardViewModel.isOkCounter()) {
      counterStorage = 0;
      _storageService.setCounter(counterStorage);
      return false;
    } else if ((!_dashboardViewModel.isOkCounter() || counterStorage >= 3) && !_dashboardViewModel.isSubscriptionActive()) {
      return true;
    }
    return false;
  }

  void setPageNumber(int pageNumber) {
    _dashboardViewModel.pageNumberResult = pageNumber;
    notifyListeners();
  }

  String imagePath() {
    return _dashboardViewModel.getImagePath();
  }

  Future<bool> getImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    try {
      if (isCamera) {
        picture = await _dashboardViewModel.takePhoto();
        // picture = await picker.pickImage(source: ImageSource.camera);
      } else {
        picture = await picker.pickImage(source: ImageSource.gallery);
      }
    } catch (exception) {
      var statusGalery = await Permission.photos.status;
      var statusCamera = await Permission.camera.status;
      if (statusGalery.isDenied || statusCamera.isDenied) {
        return true;
      }
    }
    if (picture != null) {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      _dashboardViewModel.setImage(picture);
      _firebaseApi.counterIncrement(userId);
      _dashboardViewModel.counter++;
      _dashboardViewModel.pageNumberResult = 2;
      notifyListeners();
    }
    return false;
  }

  Future<void> goSubscritionPage() async {
    await _dashboardViewModel.setTab(0);
    
    _presentationService.push(route: Routes.subscrition);
  }
}

var cameraPageViewModel =
    ViewModelProvider.autoDispose<CameraPageViewModel>((ref) {
  return CameraPageViewModel(ref);
});
