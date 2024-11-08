import 'package:finding_clothes/src/features/dashboard/application/home_view_model.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/card_number_products_scanned.dart';
import 'package:finding_clothes/src/features/dashboard/presentation/card_upgrade_plan.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_card_scan.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_scanned_card.dart';
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
      extendBodyBehindAppBar: true,
      // extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
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
      ),
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
          SafeArea(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        topWidget(
                          viewModel: viewModel,
                          counter: viewModel.counter,
                          context: context,
                          onTapGoSubscritionPage: () {
                            viewModel.goSubscritionPage();
                            debugPrint('Upgrade Plan Home');
                          },
                          onTapScanCard: () {
                            debugPrint('-- add Photo');
                            viewModel.clickScanCard();
                          },
                        ),
                        if (viewModel.isResult())
                          bottomWidget(
                            isReverse: viewModel.isReverse(),
                            sizeSearchList: viewModel.sizeSearchList(),
                            viewModel: viewModel,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget topWidget({
    required final viewModel,
    required int counter,
    required BuildContext context,
    required VoidCallback onTapGoSubscritionPage,
    required VoidCallback onTapScanCard,
  }) {
    return Column(
      children: [
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
              scanNumber: counter,
              fromNumberScan: 100,
              width: MediaQuery.sizeOf(context).width * 0.45,
              descriptionText: 'Scanned Products',
            ),
            const Spacer(),
            CardUpgradePlan(
              width: MediaQuery.sizeOf(context).width * 0.45,
              namePlan: viewModel.getNamePlan(),
              onTap: onTapGoSubscritionPage,
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
          onTap: onTapScanCard,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget bottomWidget({
    required bool isReverse,
    required int sizeSearchList,
    required final viewModel,
  }) {
    return Column(
      children: [
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
            reverse: isReverse,
            itemCount: sizeSearchList,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    width: 14,
                  ),
                  FCScannedCard(
                    image: viewModel.getImageCard(index),
                    numberScan: index,
                    onTap: () {
                      viewModel.actionSeeMore(index);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
