import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_clothes/src/features/dashboard/domain/result_model.dart';
import 'package:finding_clothes/src/features/dashboard/domain/search_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseApi {
  Future<void> addUserCounter(String userId, int counter) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'counter': counter,
    }, SetOptions(merge: true));
  }

  Future<void> counterIncrement(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'counter': FieldValue.increment(1),
    });
  }

  Future<int> getCounter(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (documentSnapshot.exists) {
        int counter = documentSnapshot.get('counter');
        return counter;
      } else {
        return -1;
      }
    } catch (e) {
      return -1;
    }
  }

  Future<void> addInitialWishList(
      String userId, List<ResultModel> wishList) async {
    await FirebaseFirestore.instance.collection('bookMarks').doc(userId).set({
      'wishList': wishList.map((item) => item.toJson()).toList(),
    });
  }

  Future<void> addElementInWishList(String userId, ResultModel item) async {
    await FirebaseFirestore.instance
        .collection('bookMarks')
        .doc(userId)
        .update({
      'wishList': FieldValue.arrayUnion([item.toJson()]),
    });
  }

  // Future<void> updateWishList(
  //     String userId, List<ResultModel> newWishList) async {
  //   await FirebaseFirestore.instance
  //       .collection('bookMarks')
  //       .doc(userId)
  //       .update({
  //     'wishList': newWishList,
  //   });
  // }

  Future<void> deleteElementFromWishList(
      String userId, ResultModel item) async {
    await FirebaseFirestore.instance
        .collection('bookMarks')
        .doc(userId)
        .update({
      'wishList': FieldValue.arrayRemove([item.toJson()]),
    });
  }

  Future<List<ResultModel>> getWishList(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('bookMarks')
          .doc(userId)
          .get();

      if (documentSnapshot.exists) {
        var wishList = documentSnapshot.get('wishList') as List<dynamic>? ?? [];

        List<ResultModel> resultModels =
            wishList.map((element) => ResultModel.fromJson(element)).toList();

        return resultModels;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  ///Search List
  Future<void> addInitialSearchList(
      String userId, List<SearchListModel> searchList) async {
    await FirebaseFirestore.instance.collection('searchFor').doc(userId).set({
      'searchList': searchList.map((item) => item.toJson()).toList(),
    });
  }

  Future<void> addElementInSearchList(String userId, SearchListModel item) async {
    debugPrint('Element to be added: ${item.toJson()}');
    try {
      await FirebaseFirestore.instance
          .collection('searchFor')
          .doc(userId)
          .update({
        'searchList': FieldValue.arrayUnion([item.toJson()]),
      });
    } catch (e) {
      debugPrint('Failed to add element to search list: $e');
    }
  }

  Future<List<SearchListModel>> getSearchList(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('searchFor')
          .doc(userId)
          .get();

      if (documentSnapshot.exists) {
        var searchList = documentSnapshot.get('searchList') as List<dynamic>? ?? [];

        List<SearchListModel> resultModels =
            searchList.map((element) => SearchListModel.fromJson(element)).toList();

        return resultModels;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

final firebaseApi = Provider<FirebaseApi>((ref) {
  return FirebaseApi();
});
