import 'package:camera/camera.dart';
import 'package:finding_clothes/src/features/dashboard/application/camera_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/features/dashboard/domain/list_result.dart';
import 'package:finding_clothes/src/features/dashboard/domain/result_model.dart';
import 'package:finding_clothes/src/features/dashboard/domain/search_list.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/bookmark_presentation/bookmark_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/home_page.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/result_presentation/result_strategy_page.dart';
import 'package:finding_clothes/src/features/subscrition/domain/subscription_model.dart';
import 'package:finding_clothes/src/features/subscrition/firebase_subscription_data/firebase_subscription_data.dart';
import 'package:finding_clothes/src/shared/utils/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/application/view_model.dart';
import '../../../shared/services/presentation_service.dart';

class DashboardViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final FirebaseApi _firebaseApi;
  late final FirebaseSubscriptionApi _firebaseSubscriptionApi;
  late final CameraViewModel _cameraViewModel;
  int counter = 0;
  int currentTab = 0;
  XFile? image;
  String imagePathSearched = '';
  ListResultModel? resultModel;
  bool isSearch = false;

  List<ResultModel> wishList = [];
  List<SearchListModel> searchList = [];

  late List<Widget> screens;

  final PageStorageBucket bucket = PageStorageBucket();
  late Widget currentScreen;
  int pageNumberResult = 1;

  SubscriptionModel subscriptionModel = SubscriptionModel(
      isFreeTrial: false, namePlan: null, startDate: null, endDate: null);

  DashboardViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _firebaseApi = ref.read(firebaseApi);
    _firebaseSubscriptionApi = ref.read(firebaseSubscriptionApi);
    _cameraViewModel = ref.read(cameratPageViewModel);

    screens = [
      const HomePage(),
      const ResultStrategyPage(),
      const BookmarkPage(),
    ];

    currentScreen = const HomePage();

    getCounter();
    getSubscription();
  }

  Future<void> getCounter() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    int response = await _firebaseApi.getCounter(userId);
    if (response < 0) {
      _firebaseApi.addUserCounter(userId, counter);
    } else {
      counter = response;
      notifyListeners();
    }
  }

  Future<void> getSubscription() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    SubscriptionModel? sbModel =
        await _firebaseSubscriptionApi.getSubscriptionPlan(userId);
    if (sbModel != null) {
      subscriptionModel = sbModel;
    } else {
      await _firebaseSubscriptionApi.addInitialSubscriptionPlan(
          userId, subscriptionModel);
    }
    notifyListeners();
  }

  Future<void> setSubscription(
      String name, DateTime startDate, DateTime endDate) async {
    subscriptionModel.namePlan = name;
    subscriptionModel.startDate = startDate;
    subscriptionModel.endDate = endDate;
    notifyListeners();
  }

  String getNamePlan() {
    return subscriptionModel.namePlan?.split(' ').first ?? 'FREE';
  }

  bool isSubscriptionActive() {
    if (subscriptionModel.endDate == null) {
      return false;
    } else {
      DateTime dateEnd = subscriptionModel.endDate ?? DateTime.now();
      if (dateEnd.isBefore(DateTime.now())) {
        return false;
      }
    }
    return true;
  }

  Future<XFile?> takePhoto() {
    return _cameraViewModel.takePhoto();
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

  String getImagePath() {
    if (image != null) {
      String path = image?.path ?? 'assets/images/register_img.png';
      return path;
    } else {
      return imagePathSearched;
    }
  }

  Future setImage(XFile? imageF) async {
    image = imageF;
    isSearch = true;
  }

  bool isThis(int index) {
    return currentTab == index;
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw "Can not launch url $uri";
    }
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
