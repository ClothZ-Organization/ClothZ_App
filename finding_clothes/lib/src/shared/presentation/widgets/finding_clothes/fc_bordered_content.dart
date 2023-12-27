
import 'dart:developer';

import 'package:flutter/material.dart';

class FCBorderedContent extends StatelessWidget {
  final double radius;
  final Widget child;
  final Color borderColor;
  final Color backgroundColor;
  final bool showsShadow;
  final double borderWidth;
  final List<BorderSideType> excludedBorders;

  FCBorderedContent({
    super.key,
    required this.child,
    this.radius = 8, 
    Color? borderColor,
    this.backgroundColor = Colors.transparent,
    this.showsShadow = false,
    this.excludedBorders = const [],
    this.borderWidth = 1
  })
  : borderColor = borderColor ?? const Color(0xFFCBD5E1) {

    if (excludedBorders.isNotEmpty && radius != 0) {
      log("Can not have border radius for some borders only.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: showsShadow ? [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            offset: const Offset(2, 2),
            blurRadius: 5,
          )
        ] : null,
        color: backgroundColor,
        borderRadius: excludedBorders.isEmpty ? BorderRadius.all(Radius.circular(radius)) : null,
        border: Border(
          left: !(excludedBorders.contains(BorderSideType.left) || excludedBorders.contains(BorderSideType.horizontal))
              ? _border
              : BorderSide.none,

          right: !(excludedBorders.contains(BorderSideType.right) || excludedBorders.contains(BorderSideType.horizontal))
              ? _border
              : BorderSide.none,

          top: !(excludedBorders.contains(BorderSideType.top) || excludedBorders.contains(BorderSideType.vertical))
              ? _border 
              : BorderSide.none,

          bottom: !(excludedBorders.contains(BorderSideType.bottom) || excludedBorders.contains(BorderSideType.vertical))
              ? _border
              : BorderSide.none,
        )
      ),
      child: child,
    );
  }

  BorderSide get _border => BorderSide(color: borderColor, width: borderWidth) ;
}

enum BorderSideType {
  top, 
  right,
  bottom,
  left,
  horizontal,
  vertical
}