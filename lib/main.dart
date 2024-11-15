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
  final List<PlaceholderChartData> chartData = [
    PlaceholderChartData('a', 10),
    PlaceholderChartData('b', 20),
    PlaceholderChartData('c', 30),
    PlaceholderChartData('d', 40),
    PlaceholderChartData('e', 50)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
    child: Stack(
      children: [
        SfCircularChart(
            series: <CircularSeries>[
            // Renders radial bar chart
            RadialBarSeries<PlaceholderChartData, String>(
            dataSource: chartData,
            xValueMapper: (PlaceholderChartData data, _) => data.x,
            yValueMapper: (PlaceholderChartData data, _) => data.y
        )
        ]
        ),
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.pink)
            ),
            child: ClipOval(
              child: Image.asset('assets/images/img3.png'),
            ),
          ),
        )
      ],
    )
    )
    );
  }
}
