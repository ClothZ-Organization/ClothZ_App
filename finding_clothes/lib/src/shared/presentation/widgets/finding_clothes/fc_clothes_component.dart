import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class FCClothesCard extends StatelessWidget {
  final String title;
  final String price;
  final String nameBrand;
  final bool isBookMark;
  final String image;
  final VoidCallback onTapBookMark;
  const FCClothesCard(
      {super.key,
      this.title = '',
      this.price = '',
      this.nameBrand = '',
      this.isBookMark = false,
      this.image =
          'https://cdn.pixabay.com/photo/2019/06/09/06/02/black-4261521_1280.jpg',
      required this.onTapBookMark});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: const Color(0xFFECECEC),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        width: 159,
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
                  SizedBox(
                    height: UIConstants.heightCardClothes * 0.68,
                    width: 159 * 0.68, //
                    child: ClipRRect(
                      child: Image.asset(
                        image,
                        // fit: BoxFit.cover,
                      ),
                      // child: CachedNetworkImage(
                      //   imageUrl: image,
                      //   placeholder: (context, url) =>
                      //       const CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) => Icon(Icons.error),
                      // ),
                    ),
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
                            size: 16,
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Text(
                          '  $nameBrand  ',
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            height: 1.3,
                            color: Color(0XFFFFFFFF),
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
