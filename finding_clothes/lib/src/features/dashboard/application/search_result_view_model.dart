import 'dart:convert';

import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/data/dashboard_api.dart';
import 'package:finding_clothes/src/features/dashboard/data/firebase_data.dart';
import 'package:finding_clothes/src/features/dashboard/domain/list_result.dart';
import 'package:finding_clothes/src/features/dashboard/domain/result_model.dart';
import 'package:finding_clothes/src/features/dashboard/domain/search_list.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/utils/constants/api_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class SearchResultViewModel extends ViewModel {
  late final DashboardViewModel _dashboardViewModel;
  late final DashboardApi _dashboardApi;
  late final FirebaseApi _firebaseApi;
  late List<ResultModel> listResultModel;
  String _imageUrl = '';
  bool isSearching = false;
  String textMessage = 'Nothing Found'; //'No scanned products yet';

  String userId = FirebaseAuth.instance.currentUser!.uid;

  SearchResultViewModel(Ref ref) {
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _firebaseApi = ref.read(firebaseApi);
    _dashboardApi = ref.read(dashboardApi);
    init();
    searchImage();
  }

  Future<void> init() async {
    if (isResult()) {
      listResultModel =
          List.from(_dashboardViewModel.resultModel!.visual_matches);
    }
  }

  Future<void> searchImage() async {
    String path =
        _dashboardViewModel.image?.path ?? 'assets/images/register_img.png';
    if (path != 'assets/images/register_img.png' &&
        _dashboardViewModel.isSearch) {
      _dashboardViewModel.isSearch = false;
      // await search(path);
      notifyListeners();
    }
  }

  Future search(String imagePath) async {
    isSearching = true;
    await _uploadImage(imagePath);
    if (_imageUrl != '') {
      ListResultModel response = await _dashboardApi.searchClothes(
        urlImg: _imageUrl,
        apiKey: ApiConstants.apiKey,
      );
      for (int i = 0; i < response.visual_matches.length; i++) {
        if(response.visual_matches[i].price == null) {
          response.visual_matches.removeAt(i);
          i--;
        }
      }
      _dashboardViewModel.resultModel = response;
      if (_dashboardViewModel.resultModel == null) {
        textMessage = 'Nothing Found';
      } else {
        listResultModel = List.from(response.visual_matches);
      }
      //adding search in database
      SearchListModel searchListModel = SearchListModel(
          imageUrl: _imageUrl, visual_matches: response.visual_matches);
      _dashboardViewModel.searchList.add(searchListModel);
      _firebaseApi.addElementInSearchList(userId, searchListModel);
      //
    }
    isSearching = false;
    notifyListeners();
  }

  Future<void> _uploadImage(String imagePath) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/${ApiConstants.cloudName}/upload');
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
    _dashboardViewModel.openUrl(listResultModel[index].link);
  }

  Future<void> addElementInWishList(int index) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    if (listResultModel[index].isBookMark ?? false) {
      _firebaseApi.deleteElementFromWishList(userId, listResultModel[index]);
      listResultModel[index].isBookMark = false;
    } else {
      listResultModel[index].isBookMark = true;
      _firebaseApi.addElementInWishList(userId, listResultModel[index]);
    }

    notifyListeners();
  }

  void changeText(String a) {
    searchBar(a);
    notifyListeners();
  }

  void searchBar(String word) {
    listResultModel =
        List.from(_dashboardViewModel.resultModel!.visual_matches);
    if (word != '') {
      for (int i = 0; i < listResultModel.length; i++) {
        if (!verify(i, word)) {
          listResultModel.removeAt(i);
          i--;
        }
      }
    }
  }

  bool verify(int index, String search) {
    if (getSource(index).toLowerCase().contains(search.toLowerCase())) {
      return true;
    }
    return false;
  }

  bool isResult() {
    return _dashboardViewModel.resultModel != null && _dashboardViewModel.resultModel!.visual_matches.isNotEmpty;
  }

  bool isResulSearchBar() {
    return listResultModel.isNotEmpty;
  }

  bool isIndexOk(int index) {
    return index < listResultModel.length;
  }

  bool isBookMark(index) {
    return listResultModel[index].isBookMark ?? false;
  }

  int? sizeResult() {
    return (listResultModel.length + 1) ~/ 2;
  }

  String getPrice(int index) {
    if (listResultModel[index].price != null) {
      return listResultModel[index].price?.value ?? '';
    }
    return '';
  }

  String getSource(int index) {
    return listResultModel[index].source;
  }

  String getTitle(int index) {
    String title = '';
    try {
      title = listResultModel[index].title;
    } catch (e) {
      return title;
    }
    return title;
  }

  String getThumbnail(int index) {
    return listResultModel[index].thumbnail;
  }
}

var searchResultViewModel =
    ViewModelProvider.autoDispose<SearchResultViewModel>((ref) {
  return SearchResultViewModel(ref);
});
