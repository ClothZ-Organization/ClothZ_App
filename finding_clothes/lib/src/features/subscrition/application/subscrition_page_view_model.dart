import 'package:finding_clothes/src/features/dashboard/application/dashboard_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/application/home_view_model.dart';
import 'package:finding_clothes/src/features/subscrition/firebase_subscription_data/firebase_subscription_data.dart';
import 'package:finding_clothes/src/shared/application/view_model.dart';
import 'package:finding_clothes/src/shared/services/presentation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pay/pay.dart';

class SubscritionPlanViewModel extends ViewModel {
  late final PresentationService _presentationService;
  late final FirebaseSubscriptionApi _firebaseSubscriptionApi;
  late final DashboardViewModel _dashboardViewModel;
  late final HomeViewModel _homeViewModel;
  int numberSelected = 1;
  double priceWeekly = 5;
  double priceYearly = 130;
  String nameWeekly = 'Weekly Plan';
  String nameYearly = 'Yearly Plan';

  List<PaymentItem> paymentItemList = [
    const PaymentItem(
      amount: '5',
      label: 'Weekly Plan',
      type: PaymentItemType.total,
      status: PaymentItemStatus.final_price,
    ),
  ];

  SubscritionPlanViewModel(Ref ref) {
    _presentationService = ref.read(presentationServiceProvider);
    _firebaseSubscriptionApi = ref.read(firebaseSubscriptionApi);
    _dashboardViewModel = ref.read(dashboardViewModelProvider);
    _homeViewModel = ref.read(homeViewModel);
  }

  void setPayment() {
    paymentItemList = [];
    if (numberSelected == 1) {
      paymentItemList.add(
        PaymentItem(
          amount: getPricePlan(1).toString(),
          label: getNamePlan(numberPlan: 1),
          type: PaymentItemType.total,
          status: PaymentItemStatus.final_price,
        ),
      );
    } else {
      paymentItemList.add(
        PaymentItem(
          amount: getPricePlan(2).toString(),
          label: getNamePlan(numberPlan: 2),
          type: PaymentItemType.total,
          status: PaymentItemStatus.final_price,
        ),
      );
    }
    // notifyListeners();
  }

  double getPricePlan(int numberPlan) {
    return numberPlan == 1 ? priceWeekly : priceYearly;
  }

  String getNamePlan({int numberPlan = 1}) {
    return numberPlan == 1 ? nameWeekly : nameYearly;
  }

  Future<void> onPaymentResult(Map<String, dynamic> result) async {
    // if (result['status'] == 'success') {
    //   debugPrint('Payment has been made successfully!');
    // } else if (result['status'] == 'error') {
    //   debugPrint('Error in the payment process: ${result['error_message']}');
    // } else if (result['status'] == 'canceled') {
    //   debugPrint('The payment has been canceled by the user.');
    // } else {
    //   debugPrint('Unknown payment status: ${result['status']}');
    // }
   await addSubscriber();
   _homeViewModel.notifyListeners();
   _presentationService.pop();
   
  }

  DateTime getEndDate() {
    late DateTime endDate; 

    if (numberSelected == 1) {
     endDate = DateTime.now().add(const Duration(days: 7));
    } else { 
      endDate = DateTime.now().add(const Duration(days: 365));
    }

    return endDate;
  }

  Future<void> addSubscriber() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await _dashboardViewModel.setSubscription(
        getNamePlan(numberPlan: numberSelected), DateTime.now(), getEndDate());
    await _firebaseSubscriptionApi.updateSubscriptionPlan(userId, _dashboardViewModel.subscriptionModel);
  }

  bool isSelected(int number) {
    return numberSelected == number;
  }

  void setPlan(int number) {
    numberSelected = number;
    setPayment();
    notifyListeners();
  }

  void goBack() {
    _presentationService.pop();
  }
}

var subscritionPlanViewModel =
    ViewModelProvider.autoDispose<SubscritionPlanViewModel>((ref) {
  return SubscritionPlanViewModel(ref);
});
