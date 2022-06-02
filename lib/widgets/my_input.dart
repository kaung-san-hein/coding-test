import 'package:flutter/material.dart';
import '../constants/theme.dart';

class MyInput extends StatelessWidget {
  final String placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;
  final bool obscureText;
  final bool disabled;
  final bool borderRadius;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int minLines;
  final int maxLines;

  const MyInput({
    Key? key,
    required this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.borderColor = UMColors.secondary,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.disabled = false,
    this.borderRadius = true,
    this.keyboardType,
    this.minLines = 1,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      readOnly: disabled,
      cursorHeight: 20.0,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      autofocus: autofocus,
      style: const TextStyle(
        height: 0.85,
        fontSize: 14.0,
        color: UMColors.black,
      ),
      validator: validator,
      obscureText: obscureText,
      textAlignVertical: const TextAlignVertical(y: 0.6),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          color: UMColors.secondary,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius
              ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          )
              : const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius
              ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          )
              : const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius
              ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          )
              : const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius
              ? const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.zero,
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          )
              : const BorderRadius.all(Radius.zero),
          borderSide: BorderSide(
              color: borderColor, width: 1.0, style: BorderStyle.solid),
        ),
        hintText: placeholder,
      ),
    );
  }
}
