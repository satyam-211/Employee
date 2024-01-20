import 'package:employee/constants/common_colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final Widget prefixWidget;
  final Widget? suffixWidget;
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final VoidCallback? onTap;

  const CommonTextField(
      {super.key,
      required this.prefixWidget,
      required this.hintText,
      this.suffixWidget,
      required this.controller,
      this.errorText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          decoration: InputDecoration(
            border: buildCommonBorder(),
            enabledBorder: buildCommonBorder(),
            disabledBorder: buildCommonBorder(),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(color: CommonColors.blueColor),
            ),
            prefixIcon: prefixWidget,
            suffixIcon: suffixWidget,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF949C9E)),
          ),
          readOnly: onTap != null,
          validator: (value) =>
              (value == null || value.isEmpty) ? errorText : null,
        ),
      ),
    );
  }

  OutlineInputBorder buildCommonBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: const BorderSide(color: CommonColors.borderColor),
    );
  }
}
