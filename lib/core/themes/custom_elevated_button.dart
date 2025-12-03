import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;

  final IconData? icon;

  const CustomElevatedButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.height = 50,

    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstants.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: ColorConstants.grey),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: ColorConstants.white,
                ),
              ),
      ),
    );
  }
}
