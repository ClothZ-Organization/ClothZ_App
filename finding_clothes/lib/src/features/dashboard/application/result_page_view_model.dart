import 'dart:convert';

import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/dashboard_api.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/features/dashboard/domain/list_result.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/utils/constants/api_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ResultPageViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  late final DashboardApi _dashboardApi;
  late final FirebaseApi _firebaseApi;
  String _imageUrl = '';
  bool isSearching = false;

  ResultPageViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _dashboardApi = ref.read(dashboardApi);
    _firebaseApi = ref.read(firebaseApi);
  }

  String imagePath() {
    String path = _dashboardViewModel.image?.path ??
        'assets/images/register_img.png'; // TODO: must be modified
    if (path != 'assets/images/register_img.png' &&
        _dashboardViewModel.isSearch) {
      _dashboardViewModel.isSearch = false;
      // search(path);
    }
    return path;
  }

  Future search(String imagePath) async {
    isSearching = true;
    await _uploadImage(imagePath);
    if (_imageUrl != '') {
      ListResultModel response = await _dashboardApi.searchClothes(
        urlImg: _imageUrl,
        apiKey: ApiConstants.apiKey,
      );
      _dashboardViewModel.resultModel = response;
    }
    isSearching = false;
    notifyListeners();
  }

  Future<void> _uploadImage(String imagePath) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/${ApiConstants.cloudName}/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = ApiConstants.uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imagePath));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);

      final url = jsonMap['url'];
      _imageUrl = url;
    }
  }

  Future<void> openUrl(int index) async {
    _dashboardViewModel.openUrl(_dashboardViewModel.resultModel!.visual_matches[index].link);
  }

  Future<void> addElementInWishList(int index) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    if (_dashboardViewModel.resultModel!.visual_matches[index].isBookMark ??
        false) {
      _firebaseApi.deleteElementFromWishList(
          userId, _dashboardViewModel.resultModel!.visual_matches[index]);
      _dashboardViewModel.resultModel?.visual_matches[index].isBookMark = false;
    } else {
      _dashboardViewModel.resultModel?.visual_matches[index].isBookMark = true;
      _firebaseApi.addElementInWishList(
          userId, _dashboardViewModel.resultModel!.visual_matches[index]);
    }

    notifyListeners();
  }

  bool isResult() {
    return _dashboardViewModel.resultModel != null;
  }

  bool isIndexOk(int index) {
    return index < _dashboardViewModel.resultModel!.visual_matches.length;
  }

  bool isBookMark(index) {
    return _dashboardViewModel.resultModel?.visual_matches[index].isBookMark ??
        false;
  }

  int? sizeResult() {
    int length = 0;
    if (_dashboardViewModel.resultModel != null) {
      return (_dashboardViewModel.resultModel!.visual_matches.length + 1) ~/ 2;
    }
    return length;
  }

  String getPrice(int index) {
    if (_dashboardViewModel.resultModel?.visual_matches[index].price != null) {
      return _dashboardViewModel
              .resultModel!.visual_matches[index].price?.value ??
          '';
    }
    return '';
  }

  String getSource(int index) {
    return _dashboardViewModel.resultModel?.visual_matches[index].source ?? '';
  }

  String getTitle(int index) {
    String title = '';
    try {
      title =
          _dashboardViewModel.resultModel?.visual_matches[index].title ?? '';
    } catch (e) {
      return title;
    }
    return title;
  }

  String getThumbnail(int index) {
    return _dashboardViewModel.resultModel?.visual_matches[index].thumbnail ??
        '';
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    debugPrint('----- Result disposed');
  }
}

var resultPageViewModel =
    ViewModelProvider.autoDispose<ResultPageViewModel>((ref) {
  return ResultPageViewModel(ref);
});
