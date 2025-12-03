import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CryptoSparkline extends StatelessWidget {
  final List<double> prices;

  const CryptoSparkline({required this.prices, super.key});

  @override 
  Widget build(BuildContext context) {
    if (prices.isEmpty) {
      return const SizedBox.shrink();
    }

    final isPositive = prices.last >= prices.first;

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: prices
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            color: isPositive ? Colors.green : Colors.red,
          )
        ],
      ),
    );
  }
}
