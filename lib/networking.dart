

import 'package:dio/dio.dart';

Future<void> fetchData() async {
  final dio = Dio();
  try {
    final response = await dio.get('');
    if (response.statusCode == 200) {
      return ;
    } else {
      throw Exception("failed to load data");
    }
  } catch (e) {
    throw Exception("Request error: $e");
  }
}