import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CoinChart extends StatelessWidget {
  final List<double> prices;

  const CoinChart({required this.prices, super.key});

  @override
  Widget build(BuildContext context) {
    if (prices.isEmpty) {
      return const SizedBox(height: 120);
    }

    final isPositive = prices.last >= prices.first;

    return SizedBox(
      height: 180,
      child: LineChart(
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
              barWidth: 3,
              color: isPositive ? Colors.green : Colors.red,
              dotData: const FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
