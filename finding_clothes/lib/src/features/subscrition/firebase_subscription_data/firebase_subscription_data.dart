import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_clothes/src/features/subscrition/domain/subscription_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseSubscriptionApi {
  Future<void> addInitialSubscriptionPlan(
      String userId, SubscriptionModel subscriptionModel) async {
    await FirebaseFirestore.instance
        .collection('subscription')
        .doc(userId)
        .set({
      'subscriptionPlan': subscriptionModel.toJson(),
    });
  }

  Future<void> updateSubscriptionPlan(
      String userId, SubscriptionModel subscriptionModel) async {
    await FirebaseFirestore.instance
        .collection('subscription')
        .doc(userId)
        .update({
      'subscriptionPlan': subscriptionModel.toJson(),
    });
  }

  Future<SubscriptionModel?> getSubscriptionPlan(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('subscription')
          .doc(userId)
          .get();

      if (documentSnapshot.exists) {
        var subscriptionResponse = documentSnapshot.get('subscriptionPlan');

        if (subscriptionResponse != null) {
          SubscriptionModel subscriptionModel =
              SubscriptionModel.fromJson(subscriptionResponse);
          return subscriptionModel;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}

final firebaseSubscriptionApi = Provider<FirebaseSubscriptionApi>((ref) {
  return FirebaseSubscriptionApi();
});

