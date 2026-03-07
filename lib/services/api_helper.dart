import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:addis_weather_v2/constants/constants.dart';
import 'package:addis_weather_v2/models/hourly_weather.dart';
import 'package:addis_weather_v2/models/weather.dart';
import 'package:addis_weather_v2/models/weekly_weather.dart';
import 'package:addis_weather_v2/services/geolocator.dart';
import 'package:addis_weather_v2/utils/logging.dart';

@immutable
class ApiHelper {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const weeklyWeatherUrl =
      'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';

  static Future<(double, double)> fetchLocation() async {
    final location = await getLocation();
    return (location.latitude, location.longitude);
  }

  static final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // current weather
  static Future<Weather> getCurrentWeather() async {
    final (lat, lon) = await fetchLocation();
    final url = _constructWeatherUrl(lat, lon);
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  // hourly weather forecast
  static Future<HourlyWeather> getHourlyForecast() async {
    final (lat, lon) = await fetchLocation();
    final url = _constructForecastUrl(lat, lon);
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  // weekly weather forecast
  static Future<WeeklyWeather> getWeeklyForecast() async {
    final (lat, lon) = await fetchLocation();
    final url = _constructWeeklyForecastUrl(lat, lon);
    final response = await _fetchData(url);
    return WeeklyWeather.fromJson(response);
  }

  // weather by city name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  static Future<HourlyWeather> getHourlyForecastByCoords(
    double lat,
    double lon,
  ) async {
    final url = _constructForecastUrl(lat, lon);
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  static Future<WeeklyWeather> getWeeklyForecastByCoords(
    double lat,
    double lon,
  ) async {
    final url = _constructWeeklyForecastUrl(lat, lon);
    final response = await _fetchData(url);
    return WeeklyWeather.fromJson(response);
  }


  // build urls
  static String _constructWeatherUrl(double lat, double lon) =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastUrl(double lat, double lon) =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructWeeklyForecastUrl(double lat, double lon) =>
      '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';

  // fetch data for a url
  static Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        printWarning('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      printWarning('Error fetching data from $url: $e');
      throw Exception('Error fetching data from API: $url');
    }
  }
}
