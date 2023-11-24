import 'package:cloud_firestore/cloud_firestore.dart';
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
}

final firebaseApi = Provider<FirebaseApi>((ref) {
  return FirebaseApi();
});
