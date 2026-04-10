import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? hintStyle; 
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isObscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const AppTextFormField({
    super.key,
    required this.hintText,
    this.hintStyle, 
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText ?? false,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? const TextStyle(color: Colors.grey, fontSize: 14), // استخدام الـ style
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF96A53A)),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}