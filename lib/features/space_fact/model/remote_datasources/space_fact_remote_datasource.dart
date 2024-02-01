import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SpaceFactRemoteDataSource {
  final apiKey = dotenv.env['NASA_api_key'];

  Future<Map<String, dynamic>> getDailySpaceFact() async {
    final String url = 'https://api.nasa.gov/planetary/apod?api_key=$apiKey';

    try {
      final response = await Dio().get<Map<String, dynamic>>(url);
      return response.data!;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getRandomSpaceFact() async {
    final String url =
        'https://api.nasa.gov/planetary/apod?api_key=$apiKey&count=1';

    try {
      final response = await Dio().get<List<dynamic>>(url);
      if (response.data != null) {
        return response.data!.map((e) => e as Map<String, dynamic>).toList()[0];
      }
    } catch (e) {
      throw Exception(e);
    }
    return <String, dynamic>{};
  }
}
