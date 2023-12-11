import 'package:cached_network_image/cached_network_image.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_button.dart';
import 'package:finding_clothes/src/shared/presentation/widgets/finding_clothes/fc_loading_indicator.dart';
import 'package:finding_clothes/src/shared/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class FCScannedCard extends StatelessWidget {
  final String image;
  final int numberScan;
  final VoidCallback onTap;
  const FCScannedCard({
    super.key,
    this.image =
        'https://images.pexels.com/photos/4100420/pexels-photo-4100420.jpeg?auto=compress&cs=tinysrgb&w=800',
    this.numberScan = 0,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFECECEC),
      ),
      width: UIConstants.widthCardClothes,
      height: UIConstants.heightCardClothes,
      child: Column(
        children: [
          SizedBox(
            height: UIConstants.heightCardClothes * 0.58,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: FCLoadingIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Your previos scan #$numberScan',
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
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FCButton(
              text: 'See more',
              fontSize: 12,
              height: 27,color: const Color(0xFF000000),
              onTap: onTap,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
