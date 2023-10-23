import 'package:flutter/material.dart';

class FCButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const FCButton({super.key, this.text = '', required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000000),
            Color(0xFF7C00FF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width / 2.2, 49),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}