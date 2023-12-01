import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CardNumberProductsScanned extends StatelessWidget {
  int scanNumber;
  int fromNumberScan;
  double width;
  final String descriptionText;
  CardNumberProductsScanned({
    super.key,
    required this.scanNumber,
    required this.fromNumberScan,
    required this.width,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 20,
        left: 22,
        right: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7C00FF),
            Color(0xFF000000),
            Color(0xFF000000),
            Color(0xFF7C00FF),
          ],
          stops: [0, 0.44, 0.6, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C00FF).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFFFFFFF).withOpacity(0.02),
            ),
            child: SvgPicture.asset(
              'lib/icons/statitics.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              height: 18,
              width: 18,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '$scanNumber/$fromNumberScan',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w500,
              fontSize: 32,
              height: 1.17,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            descriptionText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.17,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
