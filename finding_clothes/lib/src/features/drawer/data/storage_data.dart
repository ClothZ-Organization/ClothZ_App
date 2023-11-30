import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageDrawerApi {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<String> uploadPhoto(File file) async {
    Reference storageRef = _storage.ref().child('users/imageProfile/$userId');
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadurl = await snapshot.ref.getDownloadURL();

    return downloadurl;
  }

  Future<String> saveData({required File file}) async {
    String resp = '';

    try {
      String imageUrl = await uploadPhoto(file);
      await _firestore.collection('users').doc(userId).set({
        'imageUrl': imageUrl,
      }, SetOptions(merge: true));

      resp = imageUrl;
    } catch (err) {
      debugPrint('Error catch saveData in class StorageDrawerApi');
      rethrow;
    }
    return resp;
  }

  Future<String> getImageUrl() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (documentSnapshot.exists) {
        String imageUrl = documentSnapshot.get('imageUrl');
        return imageUrl;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}

final storageDrawerApi = Provider<StorageDrawerApi>((ref) {
  return StorageDrawerApi();
});
