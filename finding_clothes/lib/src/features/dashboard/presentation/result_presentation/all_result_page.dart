import 'package:finding_clothes/src/features/dashboard/application/search_result_view_model.dart';
import 'package:finding_clothes/src/shared/domain/loading_indicator_size.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_clothes_component.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_top_title_page.dart';
import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class AllResultPage extends ConsumerWidget {
  TextEditingController searchTextController = TextEditingController(text: '');
  AllResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(searchResultViewModel);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: viewModel.isSearching
          ? const Center(
              child: FCLoadingIndicator(
                size: LoadingIndicatorSize.standart,
              ),
            )
          : viewModel.isResult()
              ? Column(
                  children: [
                    searchBar(
                      onAction: (value) {
                        viewModel.changeText(value);
                      },
                      controller: searchTextController,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    viewModel.isResulSearchBar()
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: viewModel.sizeResult(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FCClothesCard(
                                            title:
                                                viewModel.getTitle(index * 2),
                                            price:
                                                viewModel.getPrice(index * 2),
                                            nameBrand:
                                                viewModel.getSource(index * 2),
                                            isBookMark:
                                                viewModel.isBookMark(index * 2),
                                            image: viewModel
                                                .getThumbnail(index * 2),
                                            onTapBookMark: () {
                                              debugPrint("Click on bookMark");
                                              viewModel.addElementInWishList(
                                                  index * 2);
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
                                                  isBookMark:
                                                      viewModel.isBookMark(
                                                          index * 2 + 1),
                                                  image: viewModel.getThumbnail(
                                                      index * 2 + 1),
                                                  onTapBookMark: () {
                                                    debugPrint(
                                                        "Click on bookMark");
                                                    viewModel
                                                        .addElementInWishList(
                                                            index * 2 + 1);
                                                  },
                                                  onTapOpenLink: () {
                                                    debugPrint(
                                                        'Click on Open link');
                                                    viewModel
                                                        .openUrl(index * 2 + 1);
                                                  },
                                                )
                                              : const SizedBox(
                                                  width: UIConstants
                                                      .widthCardClothes,
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
                        : textMessageWidget(
                            textMessage: viewModel.textMessage,
                            context: context,
                          ),
                  ],
                )
              : Column(
                  children: [
                    const Material(
                      color: Colors.black,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          // width: ,
                          child: Center(
                            child: FCTopTitlePage(
                              nameText: 'Search results',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    textMessageWidget(
                      textMessage: viewModel.textMessage,
                      context: context,
                    ),
                    const Spacer(),
                  ],
                ),
    );
  }

  Widget textMessageWidget(
      {required String textMessage, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.46,
      child: Text(
        textMessage,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
        style: const TextStyle(
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.w300,
          fontSize: 22.0,
          height: 1.2,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget searchBar(
      {required Function(String) onAction,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 40,
          child: TextField(
            keyboardAppearance: Brightness.dark,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.42,
              color: Colors.white,
            ),
            controller: controller,
            onSubmitted: onAction,
            // onChanged: onAction,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 10),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  'lib/icons/search.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                ),
              ),
              hintText: 'Search results',
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.42,
                color: Color(0xFFFFFFFF),
              ),
              // fillColor: Colors.black,
              // filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF7C00FF),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF7C00FF),
                ),
              ),
              // labelStyle: const TextStyle(
              //   fontWeight: FontWeight.w500,
              //   fontSize: 14,
              //   height: 1.42,
              //   color: Color(0xFF94A3B8),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
