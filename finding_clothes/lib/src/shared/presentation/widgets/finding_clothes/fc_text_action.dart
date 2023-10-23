import 'package:flutter/material.dart';

class FCTextAction extends StatelessWidget {
  final String text;
  final String textAction;
  final VoidCallback onTap;
  const FCTextAction(
      {super.key,
      this.text = '',
      required this.textAction,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.14,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
        children: <InlineSpan>[
           TextSpan(
            text: text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.14,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          WidgetSpan(
            child: InkWell(
              onTap:  onTap,
              splashColor: const Color(0xFFF4F6F8),
              child: Text(
                textAction,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.14,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
