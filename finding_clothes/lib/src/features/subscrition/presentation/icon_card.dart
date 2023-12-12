import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconCard extends StatelessWidget {
  final String iconPath;
  final String text;
  final double width;
  const IconCard({
    super.key,
    required this.iconPath,
    required this.text,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color(0xFF343434).withOpacity(0.9),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 12.0,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcATop),
              height: 28,
              width: 28,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.w400,
                fontSize: 9.0,
                height: 1.14,
                color: Color(0xFFFFFFFF),
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
