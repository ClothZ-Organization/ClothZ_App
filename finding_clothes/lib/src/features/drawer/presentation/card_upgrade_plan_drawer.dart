import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardUpgradePlanDrawer extends StatelessWidget {
  int scanNumber;
  int fromNumberScan;
  final String descriptionText;
  final String textButton;
  final VoidCallback onTap;
  CardUpgradePlanDrawer({
    super.key,
    required this.scanNumber,
    required this.fromNumberScan,
    required this.descriptionText,
    required this.textButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: const Color(0xFF343434),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$scanNumber/$fromNumberScan',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'WorkSans',
              fontWeight: FontWeight.w500,
              fontSize: 32,
              height: 1.13,
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
          const SizedBox(
            height: 22,
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
