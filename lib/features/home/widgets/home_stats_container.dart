import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeStatsContainer extends StatelessWidget {
  const HomeStatsContainer({Key? key}) : super(key: key);

  FlBorderData get _borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide.none,
          left: BorderSide.none,
          right: BorderSide.none,
          top: BorderSide.none,
        ),
      );

  LineChartBarData get _lineChartBarData => LineChartBarData(
        isCurved: true,
        color: const Color.fromARGB(255, 27, 169, 212),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatContainer(context),
        const SizedBox(width: 15),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMetricsContainer(context),
            const SizedBox(height: 15),
            _buildMetricsContainer(context),
          ],
        )
      ],
    );
  }

  Container _buildMetricsContainer(BuildContext context) {
    return Container(
      height: 96,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: Theme.of(context).colorScheme.tertiary,
                size: 30,
              ),
              const SizedBox(height: 6),
              Text(
                '230',
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
          const SizedBox(width: 30),
          VerticalBar(
              value: 0.1,
              color: Theme.of(context).colorScheme.tertiary,
              backgroundColor: Theme.of(context).colorScheme.background),
          const SizedBox(width: 6),
          VerticalBar(
              value: 0.2,
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.background),
          const SizedBox(width: 6),
          VerticalBar(
              value: 0.15,
              color: Theme.of(context).colorScheme.secondaryContainer,
              backgroundColor: Theme.of(context).colorScheme.background),
          const Spacer()
        ],
      ),
    );
  }

  Container _buildStatContainer(BuildContext context) {
    return Container(
      height: 210,
      width: MediaQuery.of(context).size.width * 0.47,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatIcon(context),
          _buildStatText(context),
          const SizedBox(height: 15),
          _buildLineChart(),
        ],
      ),
    );
  }

  Icon _buildStatIcon(BuildContext context) {
    return Icon(
      Icons.health_and_safety,
      color: Theme.of(context).colorScheme.primary,
      size: 45,
    );
  }

  Widget _buildStatText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('130', style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(width: 6),
        Text('Repeats', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  SizedBox _buildLineChart() {
    return SizedBox(
      height: 90,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: _borderData,
          lineBarsData: [_lineChartBarData],
        ),
      ),
    );
  }
}

class VerticalBar extends StatelessWidget {
  final double value; // Asume un valor entre 0 y 1 para la altura
  final Color color;
  final Color backgroundColor;
  final double maxHeight; // Altura máxima que puede tener la barra

  const VerticalBar({
    required this.value,
    required this.color,
    required this.backgroundColor,
    this.maxHeight = 200.0, // Por defecto será 200, pero puedes cambiarlo
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight * 0.3,
      width: 12,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ), // Ancho fijo de la barra, puedes ajustar según necesites
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: value * maxHeight,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
