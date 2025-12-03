import 'package:flutter/material.dart';

class CoinChartPlaceholder extends StatelessWidget {
  const CoinChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Center(
        child: Text("Chart Coming Soon", style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
