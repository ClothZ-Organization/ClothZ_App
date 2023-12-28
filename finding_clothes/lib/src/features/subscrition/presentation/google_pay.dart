import 'package:finding_clothes/src/features/subscrition/config/payment_config.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatelessWidget {
  const GooglePay(
      {super.key,
      required this.paymentItemsList,
      required this.onPaymentResult,
      this.onPressed});
  final List<PaymentItem> paymentItemsList;
  final void Function(Map<String, dynamic>) onPaymentResult;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GooglePayButton(
      key: UniqueKey(),
      paymentConfiguration:
          PaymentConfiguration.fromJsonString(defaultGooglePay),
      width: double.infinity,
      height: 50,
      paymentItems: paymentItemsList,
      type: GooglePayButtonType.pay,
      onPaymentResult: (result) => debugPrint('Payment Result $result'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
