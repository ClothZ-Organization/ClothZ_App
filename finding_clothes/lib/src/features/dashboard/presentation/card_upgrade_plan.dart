import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CardUpgradePlan extends StatelessWidget {
  double width;
  final VoidCallback onTap;
  CardUpgradePlan({super.key, required this.width, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xFF343434),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'FREE',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                  height: 1.17,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFC5BDBD).withOpacity(0.04),
                ),
                child: SvgPicture.asset(
                  'lib/icons/man.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF7166F9),
                    BlendMode.srcATop,
                  ),
                  height: 18,
                  width: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            'Subscription Plan',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.17,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FCButton(
            text: 'Upgrade Plan',
            fontSize: 12,
            height: 35,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
