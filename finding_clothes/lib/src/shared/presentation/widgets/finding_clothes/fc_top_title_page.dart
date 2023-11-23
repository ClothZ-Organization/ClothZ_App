import 'package:flutter/material.dart';

class FCTopTitlePage extends StatelessWidget {
  final String nameText;
  const FCTopTitlePage({super.key, this.nameText = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      height: 36,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF000010),
            Color(0xFF7C00FF),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),

      child: Center(
        child: Text(
          nameText,
          style: const TextStyle(
            fontFamily: 'WorkSans',
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            height: 1.12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
