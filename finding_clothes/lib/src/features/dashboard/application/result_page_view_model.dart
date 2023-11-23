import 'dart:convert';

import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/dashboard_api.dart';
import 'package:finding_clothes/src/features/dashboard/domain/list_result.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ResultPageViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  late final DashboardApi _dashboardApi;
  String _imageUrl = '';

  ResultPageViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _dashboardApi = ref.read(dashboardApi);
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
    await _uploadImage(imagePath);
    if (_imageUrl != '') {
      ListResultModel response = await _dashboardApi.searchClothes(
        urlImg: _imageUrl,
        apiKey: ApiConstants.apiKey,
      );
      _dashboardViewModel.resultModel = response;
      // debugPrint('--length = ${response.visual_matches.length}');
      notifyListeners();
    }
  }

  Future<void> _uploadImage(String imagePath) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dmkj3jw9a/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'pp9uwbox'
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
    final Uri uri =
        Uri.parse(_dashboardViewModel.resultModel!.visual_matches[index].link);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw "Can not launch url $uri";
    }
  }

  bool isResult() {
    return _dashboardViewModel.resultModel != null;
  }

  bool isIndexOk(int index) {
    return index < _dashboardViewModel.resultModel!.visual_matches.length;
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
}

var resultPageViewModel =
    ViewModelProvider.autoDispose<ResultPageViewModel>((ref) {
  return ResultPageViewModel(ref);
});
