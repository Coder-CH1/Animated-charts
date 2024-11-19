import 'package:animated_charts/Networking/model.dart';
import 'package:dio/dio.dart';

///ASYNCHRONOUS METHOD FOR NETWORKING
Future<WelcomeElement?> fetchAPI() async {
  final dio = Dio();
  try {
    final response = await dio.get('https://api.worldbank.org/v2/country/ng?format=json');
    if (response.statusCode == 200) {
     List<dynamic> data = response.data[1];
     if (data.isNotEmpty) {
       return WelcomeElement.fromJson(data[0]);
     }
    } else {
      throw Exception("failed to load data");
    }
  } catch (e) {
    throw Exception("Request error: $e");
  }
  return null;
}