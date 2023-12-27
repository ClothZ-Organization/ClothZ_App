import 'package:flutter/material.dart';

class FCButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final double height;
  final double cornerRadius;
  final bool isWidthMax;
  final Color color;
  final VoidCallback onTap;
  const FCButton({
    super.key,
    this.text = '',
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.height = 49.0,
    this.cornerRadius = 8.0,
    this.isWidthMax = false,
    this.color = const Color(0xFF7C00FF),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        gradient: LinearGradient(
          colors: [
            color != const Color(0xFF7C00FF) ? color : const Color(0xFF000000),
            color,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(
              MediaQuery.of(context).size.width / (isWidthMax ? 1 : 2.2),
              height),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: fontSize,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
