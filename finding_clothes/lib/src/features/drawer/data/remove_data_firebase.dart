import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoveDataFirebase {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> removeAllUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      await _firestore.collection('searchFor').doc(userId).delete();
      await _firestore.collection('bookMarks').doc(userId).delete();
      await _storage.ref().child('users/imageProfile/$userId').delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

final removeDataFirebaseApi = Provider<RemoveDataFirebase>((ref) {
  return RemoveDataFirebase();
});
