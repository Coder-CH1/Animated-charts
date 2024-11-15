import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ChartData> chartData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
    child: Container(
    child: SfCircularChart(
        series: <CircularSeries>[
        // Renders radial bar chart
        RadialBarSeries<ChartData, String>(
        dataSource: chartData,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y
    )
    ]
    )
    )
    )

    );
  }
}
