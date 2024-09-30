import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SamoleChart extends StatefulWidget {
  const SamoleChart({super.key});

  @override
  State<SamoleChart> createState() => _SamoleChartState();
}

class _SamoleChartState extends State<SamoleChart> {
  List<_ChartData> data = [];

  @override
  void initState() {
    super.initState();
    data = getChartData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: SfCartesianChart(
          primaryXAxis: const DateTimeAxis(),
          primaryYAxis: const NumericAxis(minimum: 70, maximum: 85),
          series: <CartesianSeries>[
            AreaSeries<_ChartData, DateTime>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.date,
              yValueMapper: (_ChartData data, _) => data.value,
              gradient: LinearGradient(
                colors: [
                  Colors.teal.withOpacity(0.5),
                  Colors.tealAccent.withOpacity(0.2)
                ],
                stops: const [0.2, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_ChartData> getChartData() {
    return [
      _ChartData(DateTime(1960, 1), 80),
      _ChartData(DateTime(1962, 1), 84),
      _ChartData(DateTime(1963, 1), 78),
      _ChartData(DateTime(1965, 1), 81),
      _ChartData(DateTime(1966, 1), 77),
      _ChartData(DateTime(1968, 1), 79),
    ];
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class _ChartData {
  _ChartData(this.date, this.value);

  final DateTime date;
  final double value;
}
