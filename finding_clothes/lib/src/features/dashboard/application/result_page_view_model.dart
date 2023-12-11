import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ResultPageViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  late final FirebaseApi _firebaseApi;
  String textMessage = 'No scanned products yet';
  late XFile? picture;

  ResultPageViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _firebaseApi = ref.read(firebaseApi);
    picture = _dashboardViewModel.image;
  }
  bool isCameraScanPage() {
    return _dashboardViewModel.pageNumberResult == 1;
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
}

var resultPageViewModel =
    ViewModelProvider.autoDispose<ResultPageViewModel>((ref) {
  return ResultPageViewModel(ref);
});
