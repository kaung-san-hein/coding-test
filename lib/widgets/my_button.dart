import 'package:flutter/material.dart';
import '../constants/theme.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final IconData? icon;

  const MyButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.white,
        primary: UMColors.primary,
        minimumSize: const Size(88, 36),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.zero,
            bottomRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null ? Icon(icon) : Container(),
          Text(label),
        ],
      ),
    );
  }
}
