import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FCBottomTabBarButton extends StatelessWidget {
  final bool isSelected;
  final IconData iconButton;
  final VoidCallback onTap;
  const FCBottomTabBarButton(
      {super.key,
      required this.isSelected,
      required this.iconButton,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor:
          Colors.transparent, 
      highlightColor:
          Colors.transparent, 
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
          Icon(
            size: 30,
            iconButton,
            color: isSelected ? const Color(0xFF7C00FF) : Colors.white,
          ),
        ],
      ),
    );
  }
}
