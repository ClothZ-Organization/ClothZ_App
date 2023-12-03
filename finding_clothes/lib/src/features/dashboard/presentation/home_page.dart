import 'package:finding_clothes/src/features/dashboard/application/home_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/card_number_products_scanned.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/card_upgrade_plan.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_clothes_component.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_card_scan.dart';
import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(homeViewModel);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width / 2,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/womenD.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                width: MediaQuery.sizeOf(context).width / 2,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/images/manD.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 40,
            leading: IconButton(
              highlightColor: Colors.grey,
              iconSize: 24,
              icon: SvgPicture.asset(
                'lib/icons/category.svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                height: 24,
                width: 24,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
                debugPrint('Preessed grid_view');
              },
            ),
            // actions: [
            //   IconButton(
            //     highlightColor: Colors.grey,
            //     iconSize: 24,
            //     icon: SvgPicture.asset(
            //       'lib/icons/setting.svg',
            //       colorFilter:
            //           const ColorFilter.mode(Colors.white, BlendMode.srcATop),
            //       height: 24,
            //       width: 24,
            //     ),
            //     onPressed: () {
            //       debugPrint('Preessed settings');
            //     },
            //   ),
            // ],
          ),
          SafeArea(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Hello 👋🏻",
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0,
                    height: 1.17,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    CardNumberProductsScanned(
                      scanNumber: viewModel.counter,
                      fromNumberScan: 100,
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      descriptionText: 'Scanned Products',
                    ),
                    const Spacer(),
                    CardUpgradePlan(
                      width: MediaQuery.sizeOf(context).width * 0.45,
                      onTap: () {
                        debugPrint('Upgrade Plan Home');
                      },
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                FCCardScan(
                  titleText: 'Search products',
                  descriptionText:
                      'Upload your own photo to find similar products and the best prices.',
                  iconPath: 'lib/icons/scan.svg',
                  onTap: () async {
                    debugPrint('-- add Photo');
                    viewModel.clickScanCard();
                    // if (await viewModel.getImage(true)) {
                    //   // ignore: use_build_context_synchronously
                    //   FCDialogUtils.showAlertDialog(context);
                    // }
                  },
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Searched Products",
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          height: 1.14,
                          color: Color(0xFFFFFFFF),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(
                  height: UIConstants.heightCardClothes,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          FCClothesCard(
                            title: 'title $index',
                            price: '\$$index',
                            nameBrand: 'H&M',
                            isBookMark: viewModel.isBookMark,
                            // image: 'assets/images/imgClst.jpeg',
                            // image: viewModel.image?.path ?? 'assets/images/imgClst.jpeg',
                            onTapBookMark: () {
                              debugPrint("Click on bookMark");
                              viewModel.change();
                            },
                            onTapOpenLink: () {
                              debugPrint('Click on Open link');
                            },
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
