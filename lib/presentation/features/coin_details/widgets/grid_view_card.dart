import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class GridViewCard extends StatelessWidget {
  final String title;
  final String value;
  const GridViewCard({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
