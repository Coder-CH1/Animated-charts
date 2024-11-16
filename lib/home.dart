import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'networking.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<PlaceholderChartData> chartData = [];

  @override
//LIFE CYCLE
  void initState(){
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await  fetchAPI();
      if (data != null) {
        setState(() {
          chartData = [
            PlaceholderChartData('Region: ${data.region.value}', 50),
            PlaceholderChartData('Income level: ${data.incomeLevel.value}', 100),
            PlaceholderChartData('Capital: ${data.capitalCity}', 150),
            PlaceholderChartData('Lending type: ${data.lendingType.value}', 200),
          ];
        });
      }
    } catch (e) {
      throw Exception("failed to load data $e");
    }
  }

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
                        border: Border.all(color: Colors.black)
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
