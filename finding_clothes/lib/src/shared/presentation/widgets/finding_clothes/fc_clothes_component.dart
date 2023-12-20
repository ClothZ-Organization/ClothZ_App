import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FCClothesCard extends StatelessWidget {
  final String title;
  final String price;
  final String currency;
  final double extractedValue;
  final String nameBrand;
  final String iconBrand;
  final bool isBookMark;
  final String image;
  final bool isDiscount;
  final int discount;
  final VoidCallback onTapBookMark;
  final VoidCallback onTapOpenLink;
  const FCClothesCard({
    super.key,
    this.title = '',
    this.price = '',
    this.currency = '',
    this.extractedValue = 0.0,
    this.nameBrand = '',
    this.iconBrand = '',
    this.isBookMark = false,
    this.image =
        'https://images.pexels.com/photos/4100420/pexels-photo-4100420.jpeg?auto=compress&cs=tinysrgb&w=800',
    this.isDiscount = false,
    this.discount = 10,
    required this.onTapBookMark,
    required this.onTapOpenLink,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        width: UIConstants.widthCardClothes,
        height: UIConstants.heightCardClothes,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: UIConstants.heightCardClothes * 0.68,
                        width: UIConstants.widthCardClothes * 0.68, //
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: FCLoadingIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onTapOpenLink,
                        child: Center(
                          child: Container(
                            height: UIConstants.heightCardClothes * 0.58,
                            width: UIConstants.widthCardClothes * 0.58,
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 9,
                bottom: 12,
                left: 12,
                right: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (isDiscount) discountBox(discount: discount),
                      const Spacer(),
                      GestureDetector(
                        onTap: onTapBookMark,
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xFF7C00FF),
                                Colors.black,
                              ],
                              tileMode: TileMode.clamp,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: SvgPicture.asset(
                            isBookMark
                                ? 'lib/icons/bookmark_full.svg'
                                : 'lib/icons/bookmark.svg',
                            colorFilter: ColorFilter.mode(
                                isBookMark
                                    ? const Color(0xFFFFFFFF)
                                    : Colors.black,
                                BlendMode.srcATop),
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.33,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '$currency$extractedValue', //price.replaceAll('*', ''),
                        style: TextStyle(
                          decoration: isDiscount
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: Colors.red,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.33,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      if (isDiscount)
                        Text(
                          '$currency${extractedValue - (0.1 * extractedValue)}',
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.33,
                            color: Colors.red,
                          ),
                        ),
                      const Spacer(),
                      iconBrand == ''
                          ? Flexible(
                              child: Container(
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(9.0),
                                ),
                                child: Center(
                                  child: Text(
                                    nameBrand,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      height: 1.3,
                                      color: Color(0XFFFFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: UIConstants.heightCardClothes * 0.07,
                              width: UIConstants.widthCardClothes * 0.20,
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: iconBrand,
                                  // fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const Center(child: FCLoadingIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget discountBox({required int discount}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF7C00FF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        child: Text(
          '$discount% EXTRA',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: const TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w500,
            fontSize: 9,
            height: 1.77,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
