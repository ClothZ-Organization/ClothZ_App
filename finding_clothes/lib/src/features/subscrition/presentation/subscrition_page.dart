import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:finding_clothes/src/features/subscrition/application/subscrition_page_view_model.dart';
import 'package:finding_clothes/src/features/subscrition/presentation/apple_pay.dart';
import 'package:finding_clothes/src/features/subscrition/presentation/google_pay.dart';
import 'package:finding_clothes/src/features/subscrition/presentation/icon_card.dart';
import 'package:finding_clothes/src/features/subscrition/presentation/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class SubscritionPage extends ConsumerWidget {
  const SubscritionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(subscritionPlanViewModel);

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/backgroundSubscrition.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    highlightColor: Colors.grey,
                    iconSize: 22,
                    icon: SvgPicture.asset(
                      'lib/icons/arrow-back.svg',
                      colorFilter: const ColorFilter.mode(
                          Colors.white, BlendMode.srcATop),
                      height: 22,
                      width: 22,
                    ),
                    onPressed: () {
                      viewModel.goBack();
                      debugPrint("Press back");
                    },
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 35,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "Restore",
                            style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              height: 1.2,
                              color: Color(0xFFFFFFFF),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.37,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Positioned(
                        right: (-1) * MediaQuery.sizeOf(context).width * 0.14,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          height: MediaQuery.sizeOf(context).height * 0.37,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/purplePlan.png'),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.49,
                            height: MediaQuery.sizeOf(context).height * 0.23,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/scanner.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.28,
                            padding: const EdgeInsets.only(
                              left: 33,
                            ),
                            child: Image.asset(
                              'assets/images/textSubscrition.png',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    IconCard(
                      iconPath: 'lib/icons/scan-subscrition.svg',
                      text: 'Unlimited Scans',
                      width: MediaQuery.sizeOf(context).width * 0.19,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconCard(
                      iconPath: 'lib/icons/ticket-discount.svg',
                      text: 'Discount Coupons',
                      width: MediaQuery.sizeOf(context).width * 0.19,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconCard(
                      iconPath: 'lib/icons/lightning.svg',
                      text: 'Faster Scan Results',
                      width: MediaQuery.sizeOf(context).width * 0.19,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    IconCard(
                      iconPath: 'lib/icons/ads.svg',
                      text: ' No\nADS',
                      width: MediaQuery.sizeOf(context).width * 0.19,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      PlanCard(
                        isSelected: viewModel.isSelected(1),
                        text:
                            'Free 3-day trial, then \$${viewModel.getPricePlan(1)}/week',
                        onTap: () {
                          viewModel.setPlan(1);
                        },
                      ),
                      PlanCard(
                        isSelected: viewModel.isSelected(2),
                        text:
                            'Free 3-day trial, then \$${viewModel.getPricePlan(2)}/year',
                        onTap: () {
                          viewModel.setPlan(2);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // FCButton(
                      //   text: 'Continue',
                      //   fontSize: 19,
                      //   cornerRadius: 27,
                      //   isWidthMax: true,
                      //   onTap: () {
                      //     viewModel.paySubscrition();
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Platform.isIOS
                          ? ApplePay(
                              paymentItemsList: viewModel.paymentItemList,
                              onPaymentResult: (result) async {
                                await viewModel.onPaymentResult(result);
                                debugPrint(
                                    'Payment Result $result ---${result['status']}');
                                
                              },
                            )
                          : GooglePay(
                              paymentItemsList: viewModel.paymentItemList,
                              onPaymentResult: (result) async {
                                await viewModel.onPaymentResult(result);
                                debugPrint('Payment Result $result');
                              },
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.paddingOf(context).bottom,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget applePayButton(
  //     {required List<PaymentItem> paymentItemsList,
  //     required VoidCallback onPressed}) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(28),
  //     child: ApplePayButton(
  //       key: UniqueKey(),
  //       paymentConfiguration:
  //           PaymentConfiguration.fromJsonString(defaultApplePay),
  //       paymentItems: List.from(paymentItemsList),
  //       style: ApplePayButtonStyle.white,
  //       width: double.infinity,
  //       height: 50,
  //       type: ApplePayButtonType.inStore,
  //       // margin: const EdgeInsets.only(top: 15.0),
  //       onPaymentResult: (result) => debugPrint('Payment Result $result'),
  //       onPressed: onPressed,
  //       loadingIndicator: const Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //     ),
  //   );
  // }

  // Widget googlePayButton({required List<PaymentItem> paymentItemsList}) {
  //   return GooglePayButton(
  //     key: UniqueKey(),
  //     paymentConfiguration:
  //         PaymentConfiguration.fromJsonString(defaultGooglePay),
  //     paymentItems: paymentItemsList,
  //     width: double.infinity,
  //     height: 50,
  //     type: GooglePayButtonType.pay,
  //     // margin: const EdgeInsets.only(top: 15.0),
  //     onPaymentResult: (result) => debugPrint('Payment Result $result'),
  //     loadingIndicator: const Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }
}
