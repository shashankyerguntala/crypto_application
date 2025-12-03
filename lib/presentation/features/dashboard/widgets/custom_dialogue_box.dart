import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String message;

  const CustomDialogBox({
    required this.title,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(StringConstants.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            StringConstants.remove,
            style: TextStyle(color: ColorConstants.error),
          ),
        ),
      ],
    );
  }
}
