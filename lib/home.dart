import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Networking/networking.dart';
import 'Networking/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late WelcomeElement data;
  late List<Map<String, dynamic>> chartData = [];
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
//LIFE CYCLE
  void initState(){
    super.initState();
    fetchData();
    
    _animationController = AnimationController(
        vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _sizeAnimation = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
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
                  AnimatedBuilder(
              animation: _animationController,
                    builder: (context, child) {
                       return Transform.scale(
                         scale: _sizeAnimation.value,
                         child: SfCircularChart(
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
                                               textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink),
                                               builder: (context, point, series, pointIdex, seriesIndex) {
                                               final xValue = point.x;
                                               final yValue = point.y;
                                               return Text('$xValue: $yValue');
                                               },
                                               )
                                               ,
                                               )
                                               ]
                                               ),
                       );
                    }
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
                        child: Image.asset('assets/images/nigeria.png'),
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
