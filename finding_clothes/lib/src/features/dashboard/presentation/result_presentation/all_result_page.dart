import 'package:finding_clothes/src/features/dashboard/application/result_page_view_model.dart';
import 'package:finding_clothes/src/shared/domain/loading_indicator_size.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_clothes_component.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllResultPage extends ConsumerWidget {
  const AllResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(resultPageViewModel);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          viewModel.isSearching
              ? const Center(
                  child: FCLoadingIndicator(
                    size: LoadingIndicatorSize.standart,
                  ),
                )
              : viewModel.isResult()
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.sizeResult(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FCClothesCard(
                                      title: viewModel.getTitle(index * 2),
                                      price: viewModel.getPrice(index * 2),
                                      nameBrand: viewModel.getSource(index * 2),
                                      isBookMark:
                                          viewModel.isBookMark(index * 2),
                                      image: viewModel.getThumbnail(index * 2),
                                      onTapBookMark: () {
                                        debugPrint("Click on bookMark");
                                        viewModel
                                            .addElementInWishList(index * 2);
                                      },
                                      onTapOpenLink: () {
                                        debugPrint('Click on Open link');
                                        viewModel.openUrl(index * 2);
                                      },
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    viewModel.isIndexOk(index * 2 + 1)
                                        ? FCClothesCard(
                                            title: viewModel
                                                .getTitle(index * 2 + 1),
                                            price: viewModel
                                                .getPrice(index * 2 + 1),
                                            nameBrand: viewModel
                                                .getSource(index * 2 + 1),
                                            isBookMark: viewModel
                                                .isBookMark(index * 2 + 1),
                                            image: viewModel
                                                .getThumbnail(index * 2 + 1),
                                            onTapBookMark: () {
                                              debugPrint("Click on bookMark");
                                              viewModel.addElementInWishList(
                                                  index * 2 + 1);
                                            },
                                            onTapOpenLink: () {
                                              debugPrint('Click on Open link');
                                              viewModel.openUrl(index * 2 + 1);
                                            },
                                          )
                                        : const SizedBox(
                                            width: UIConstants.widthCardClothes,
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          }),
                    )
                  : SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.46,
                  child: Text(
                    viewModel.textMessage,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 30.0,
                      height: 1.2,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
