import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class HelperFunctions {
  static void showSnackBar(
    String msg,
    BuildContext context, {
    required bool isError,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: ColorConstants.white, fontSize: 14),
        ),
        backgroundColor: (isError ? Colors.red : Colors.green).withAlpha(90),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.emailEmpty;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstants.passEmpty;
    }
    
    return null;
  }
}
