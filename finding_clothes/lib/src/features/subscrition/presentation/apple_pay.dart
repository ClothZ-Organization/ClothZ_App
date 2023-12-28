import 'package:finding_clothes/src/features/subscrition/config/payment_config.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class ApplePay extends StatelessWidget {
  const ApplePay({
    super.key,
    required this.paymentItemsList,
    required this.onPaymentResult,
    this.onPressed
  });
  final List<PaymentItem> paymentItemsList;
  final void Function(Map<String, dynamic>) onPaymentResult;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: ApplePayButton(
        key: UniqueKey(),
        paymentConfiguration:
            PaymentConfiguration.fromJsonString(defaultApplePay),
        onPaymentResult: onPaymentResult,
        width: double.infinity,
        height: 50,
        paymentItems: paymentItemsList,
        style: ApplePayButtonStyle.white,
        type: ApplePayButtonType.inStore,
        loadingIndicator: const CircularProgressIndicator(),
        onPressed: onPressed,
      ),
    );
  }
}
