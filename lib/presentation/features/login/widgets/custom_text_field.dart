import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.controller,
    required this.label,
    super.key,
    this.validator,
    this.isPassword = false,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  OutlineInputBorder border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: isPassword ? TextInputType.visiblePassword : keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        suffixIcon: isPassword ? suffixIcon : null,
        enabledBorder: border(Colors.grey.shade500),
        focusedBorder: border(Colors.blue),
        errorBorder: border(Colors.red),
        focusedErrorBorder: border(Colors.red.shade300),
      ),
    );
  }
}
