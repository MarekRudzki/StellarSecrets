import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DailyDataRemoteDatasource {
  Future<Map<String, dynamic>> getDailyData() async {
    final apiKey = dotenv.env['NASA_api_key'];
    final String url = 'https://api.nasa.gov/planetary/apod?api_key=$apiKey';

    try {
      final response = await Dio().get<Map<String, dynamic>>(url);
      return response.data!;
    } catch (e) {
      throw Exception();
    }
  }
}
