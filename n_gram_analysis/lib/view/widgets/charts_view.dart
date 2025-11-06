import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FrequencyChart extends StatelessWidget {
  final String title;
  final Map<String, int> data;

  const FrequencyChart({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final items = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final topItems = items.take(10).toList();

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() < topItems.length) {
                            return Transform.rotate(
                              angle: 45 * 3.1415927 / 180, // угол в радианах
                              child: Text(
                                topItems[value.toInt()].key,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  barGroups: [
                    for (int i = 0; i < topItems.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: topItems[i].value.toDouble(),
                            color: Theme.of(context).colorScheme.primary,
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
