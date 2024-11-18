import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Networking/networking.dart';
import 'Networking/model.dart';


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

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late WelcomeElement data;
  late List<Map<String, dynamic>> chartData = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

//LIFE CYCLE
  @override
  void initState(){
    super.initState();
    fetchData();

    //INITIALIZE ANIMATION CONTROLLER
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    //INITIALIZE ANIMATION
    _animation = Tween<double>(begin: 0.5, end: 1.2).animate(_animationController);
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

//METHOD TO CALL THE METHOD FOR FETCHING THE API
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
                      animation: _animation,
                      builder: (context, child) {
                        return SfCircularChart(
                            title: const ChartTitle(
                              text: 'World Bank Data Overview for Nigeria',
                            ),
                            series: <CircularSeries>[

                              // Renders radial bar chart
                              RadialBarSeries<Map<String, dynamic>, String>(
                                dataSource: chartData,
                                xValueMapper: (Map<String, dynamic> data, _) => data['x'],
                                yValueMapper: (Map<String, dynamic> data, _) => data['y'],
                                radius: '${_animation.value}',
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink),
                                  builder: (context, point, series, pointIdex, seriesIndex) {
                                    final xValue = point.x;
                                    final yValue = point.y;
                                    return Text('$xValue: $yValue');
                                  },
                                ),
                              )
                            ]
                        );
                      }
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green)
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

//DISPOSING OF THE CONTROLLER
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
