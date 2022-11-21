import 'dart:convert';

import '../models/weather_data_model.dart';
import 'package:http/http.dart';

class WeatherRepository {
  final Client client;
  final String url;
  final String apiKey;

  WeatherRepository(this.client, this.url, this.apiKey);

  Future<WeatherData> getWeatherData(double lat, double lng) async {
   var response = await client.get(
      Uri.https(
          url, 'data/2.5/weather',  {'lat': lat.toString(), 'lon': lng.toString(), 'appid': apiKey}),
    );
    if (response.statusCode == 200) {
      WeatherData data = WeatherData.fromJson(jsonDecode(response.body));
      return data;
    } else {
      throw Exception('API ERROR : ${jsonDecode(response.body)['message']}');
    }
  }
}
