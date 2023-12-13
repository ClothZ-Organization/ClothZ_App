import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FCTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;
  final bool isObscureText;
  bool isNotOk;
  String? textIsNotOk;

  FCTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    this.isObscureText = false,
    this.isNotOk = false,
    this.textIsNotOk,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isNotOk && textIsNotOk != null ? 80 : 50,
      child: TextFormField(
        validator: (_) {
          return textIsNotOk;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardAppearance: Brightness.dark,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.42,
          color: Colors.white,
        ),
        controller: controller,
        onChanged: onChanged,
        obscureText: isObscureText,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10),
          fillColor: const Color(0xFF000000).withOpacity(0.5),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isNotOk ? Colors.red : const Color(0xFFC4C4C4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isNotOk ? Colors.red : const Color(0xFFC4C4C4),
            ),
          ),
          errorMaxLines: 2,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.64,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
