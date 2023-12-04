import 'package:camera/camera.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late List<CameraDescription> cameras;
late CameraController cameraController;

class CameraPageViewModel extends ViewModel {
  CameraPageViewModel(Ref ref) {
    initCamera();
  }

  Future<void> initCamera() async {
    WidgetsFlutterBinding.ensureInitialized();

    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      notifyListeners();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            debugPrint('--- CameraAccessDenied');
            break;
          default:
            debugPrint('--- ${e.description}');
            break;
        }
      }
    });
  }

  Future<XFile?> takePhoto() async {
    late XFile? picture;
    if (cameraController.value.isInitialized &&
        !cameraController.value.isTakingPicture) {
      try {
        await cameraController.setFlashMode(FlashMode.auto);
        picture = await cameraController.takePicture();
      } on CameraException catch (e) {
        debugPrint('Error ocurred while taking picture: $e');
      }
    }
    return picture;
  }
}

var cameratPageViewModel =
    ViewModelProvider.autoDispose<CameraPageViewModel>((ref) {
  return CameraPageViewModel(ref);
});
