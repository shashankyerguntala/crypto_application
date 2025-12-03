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
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator()
            : Text(label, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
