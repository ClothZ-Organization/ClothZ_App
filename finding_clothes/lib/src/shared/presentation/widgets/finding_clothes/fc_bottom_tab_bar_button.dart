import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FCBottomTabBarButton extends StatelessWidget {
  final bool isSelected;
  final String iconButtonPath;
  final VoidCallback onTap;
  const FCBottomTabBarButton(
      {super.key,
      required this.isSelected,
      required this.iconButtonPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 8,
            width: 72,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF7C00FF) : Colors.transparent,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SvgPicture.asset(
            iconButtonPath,
            colorFilter: ColorFilter.mode(
                isSelected ? const Color(0xFF7C00FF) : Colors.white,
                BlendMode.srcATop),
            height: 24,
            width: 24,
          ),
        ],
      ),
    );
  }
}
