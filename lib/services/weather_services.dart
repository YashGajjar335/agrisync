import 'dart:convert';
import 'package:agrisync/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = '4ff912b4e033419798194617250202';
  static const String baseUrl = 'http://api.weatherapi.com/v1/forecast.json';

  Future<WeatherData> fetchWeatherData(String location) async {
    final response =
        await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$location&days=7'));

    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
