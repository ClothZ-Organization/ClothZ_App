import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/features/dashboard/domain/result_model.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookMarkPageViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  late final FirebaseApi _firebaseApi;

  BookMarkPageViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _firebaseApi = ref.read(firebaseApi);
    getList();
  }

  Future<void> getList() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<ResultModel> response = await _firebaseApi.getWishList(userId);
    if (response.isNotEmpty) {
      _dashboardViewModel.wishList = response;
      notifyListeners();
    } else {
      _firebaseApi.addInitialWishList(userId, _dashboardViewModel.wishList);
    }
  }

  void deleteElementFromWishList(int index) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    _firebaseApi.deleteElementFromWishList(
        userId, _dashboardViewModel.wishList[index]);
    _dashboardViewModel.wishList[index].isBookMark = false;
    _dashboardViewModel.wishList.removeAt(index);
    notifyListeners();
  }

  bool isBookMark(int index) {
    return _dashboardViewModel.wishList[index].isBookMark ?? false;
  }

  bool isWishList() {
    return _dashboardViewModel.wishList.isNotEmpty;
  }

  int sizeWishList() {
    return (_dashboardViewModel.wishList.length + 1) ~/ 2;
  }

  Future<void> openUrl(int index) async {
    _dashboardViewModel.openUrl(_dashboardViewModel.wishList[index].link);
  }

  bool isIndexOk(int index) {
    return index < _dashboardViewModel.wishList.length;
  }

  String getPrice(int index) {
    if (_dashboardViewModel.wishList[index].price != null) {
      return _dashboardViewModel.wishList[index].price?.value ?? '';
    }
    return '';
  }

  String getSource(int index) {
    return _dashboardViewModel.wishList[index].source;
  }

  String getIconSource(int index) {
    return _dashboardViewModel.wishList[index].sourceIcon ?? '';
  }

  String getTitle(int index) {
    String title = '';
    try {
      title = _dashboardViewModel.wishList[index].title;
    } catch (e) {
      return title;
    }
    return title;
  }

  String getThumbnail(int index) {
    return _dashboardViewModel.wishList[index].thumbnail;
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();

  //   debugPrint('----- BookMark disposed');
  // }
}

var bookmarkPageViewModel =
    ViewModelProvider.autoDispose<BookMarkPageViewModel>((ref) {
  return BookMarkPageViewModel(ref);
});
