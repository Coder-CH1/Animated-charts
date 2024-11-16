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
  late WelcomeElement data;
  late List<Map<String, dynamic>> chartData = [];

  @override
//LIFE CYCLE
  void initState(){
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final fetchData = await  fetchAPI();
      if (fetchData != null) {
        setState(() {
          data = fetchData;
          chartData = [
           {'x': 'Region: ${data.region.value}', 'y': 50},
            {'x':'Income level: ${data.incomeLevel.value}', 'y': 100},
            {'x':'Capital: ${data.capitalCity}','y': 150},
            {'x':'Lending type: ${data.lendingType.value}','y': 200},
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
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Stack(
                children: [
                  SfCircularChart(
                    title: const ChartTitle(
                        text: 'World Bank Data Overview for Nigeria',
                    ),
                      series: <CircularSeries>[
                        // Renders radial bar chart
                        RadialBarSeries<Map<String, dynamic>, String>(
                            dataSource: chartData,
                            xValueMapper: (Map<String, dynamic> data, _) => data['x'],
                            yValueMapper: (Map<String, dynamic> data, _) => data['y'],
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.inside,
                              //labelAlignment: ChartDataLabelAlignment.outer,
                                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink),
                                builder: (context, point, series, pointIdex, seriesIndex) {
                                final xValue = point.x;
                                final yValue = point.y;
                                return Text('$xValue: $yValue');
                                },
                            ),
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
              ),
            )
        )
    );
  }
}
