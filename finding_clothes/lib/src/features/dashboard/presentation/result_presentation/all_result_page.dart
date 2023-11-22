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
          viewModel.isResult()
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
                                  // isBookMark: false,
                                  image: viewModel.getThumbnail(index * 2),
                                  onTapBookMark: () {
                                    debugPrint("Click on bookMark");
                                  },
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                viewModel.isIndexOk(index * 2 + 1)
                                    ? FCClothesCard(
                                        title:
                                            viewModel.getTitle(index * 2 + 1),
                                        price:
                                            viewModel.getPrice(index * 2 + 1),
                                        nameBrand:
                                            viewModel.getSource(index * 2 + 1),
                                        image: viewModel
                                            .getThumbnail(index * 2 + 1),
                                        onTapBookMark: () {
                                          debugPrint("Click on bookMark");
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
              : const Center(
                  child: FCLoadingIndicator(
                    size: LoadingIndicatorSize.standart,
                  ),
                )
        ],
      ),
    );
  }
}
