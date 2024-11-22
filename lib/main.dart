import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'Networking/networking.dart';
import 'Networking/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

/// THIS WIDGET IS THE ROOT OF YOUR APPLICATION.
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
  int _animationCount = 0;

/// LIFE CYCLE
  @override
  void initState(){
    super.initState();
    fetchData();
/// INITIALIZE ANIMATION CONTROLLER
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
/// INITIALIZE ANIMATION
    _animation = Tween<double>(begin: 0, end: 200).animate(_animationController);
    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_animationCount < 5) {
          _animationController.reverse();
          setState(() {
            _animationCount++;
          });
        } else {
          _animationController.stop();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_animationCount < 5) {
          _animationController.forward();
        }
      }
    });
  }

/// METHOD TO CALL THE METHOD FOR FETCHING THE API
  Future<void> fetchData() async {
    try {
      final fetchData = await  fetchAPI();
      if (fetchData != null) {
        setState(() {
          data = fetchData;
          chartData = [
            {'x': 'Region: ${data.region.value}', 'y': 50},
            {'x':'Income Level: ${data.incomeLevel.value}', 'y': 80},
            {'x':'Capital: ${data.capitalCity}','y': 120},
            {'x':'Lending Type: ${data.lendingType.value}','y': 160},
          ];
        });
      }
    } catch (err) {
      throw Exception("failed to load data $err");
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
                          textStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        series: <CircularSeries>[
                          /// RENDERS RADIAL BAR CHARTS
                      RadialBarSeries<Map<String, dynamic>, String>(
                        dataSource: chartData,
                        maximumValue: _animation.value,
                        gap: '10%',
                        xValueMapper: (Map<String, dynamic> data, _) => data['x'],
                      yValueMapper: (Map<String, dynamic> data, _) => data['y'],
                      radius: '100%',
                      trackOpacity: 0.3,
                      opacity: 1.0,
                      cornerStyle: CornerStyle.bothCurve,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        builder: (context, point, series, pointIdex, seriesIndex) {
                          final xValue = point.x;
                          final yValue = point.y;
                          return Text('$xValue: $yValue');
                        },
                      ),
                    ),
                        ],
                    );
                    },
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

/// DISPOSING OF THE CONTROLLER
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

