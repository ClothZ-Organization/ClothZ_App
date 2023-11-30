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
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
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
          ),
        ],
      ),
    );
  }
}
