import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_clothes/src/shared/domain/loading_indicator_size.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class FCClothesCard extends StatelessWidget {
  final String title;
  final String price;
  final String nameBrand;
  final bool isBookMark;
  final String image;
  final VoidCallback onTapBookMark;
  final VoidCallback onTapOpenLink;
  const FCClothesCard({
    super.key,
    this.title = '',
    this.price = '',
    this.nameBrand = '',
    this.isBookMark = false,
    this.image =
        'https://images.pexels.com/photos/4100420/pexels-photo-4100420.jpeg?auto=compress&cs=tinysrgb&w=800',
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
                          // child: Image.asset(
                          //   image,
                          //   // fit: BoxFit.cover,
                          // ),
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
                top: 6,
                bottom: 12,
                left: 12,
                right: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                          child: Icon(
                            isBookMark ? Icons.bookmark : Icons.bookmark_border,
                            size: 24,
                            color: isBookMark
                                ? const Color(0xFFFFFFFF)
                                : Colors.black,
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
                        price,
                        style: const TextStyle(
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          height: 1.33,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Flexible(
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
}
