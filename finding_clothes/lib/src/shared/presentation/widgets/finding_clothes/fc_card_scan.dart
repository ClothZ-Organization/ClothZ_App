import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FCCardScan extends StatelessWidget {
  final String titleText;
  final String descriptionText;
  final String iconPath;
  final VoidCallback onTap;
  const FCCardScan({
    super.key,
    required this.titleText,
    required this.descriptionText,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        color: const Color(0xFF222222).withOpacity(0.7),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: onTap,
          splashColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  SvgPicture.asset(
                    iconPath,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                    height: 78,
                    width: 78,
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            height: 1.17,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          descriptionText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.33,
                            color: Colors.white,
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
