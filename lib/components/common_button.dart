import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String labelText;
  final VoidCallback onPressed;

  const CommonButton({super.key,
    required this.backgroundColor,
    required this.labelText,
    required this.onPressed, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(labelText,style: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),),
    );
  }
}
