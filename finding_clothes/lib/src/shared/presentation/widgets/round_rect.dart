import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundRect extends StatelessWidget {
  late final Color color;
  final double radius;
  final Widget? child;

  RoundRect({
    Color? color,
    super.key,
    this.radius = 4,
    this.child
  }) {
    this.color = color ?? Colors.transparent; //Colors.black.withOpacity(0.1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
        border: null,
      ),
      child: child,
    );
  }
}
