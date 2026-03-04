import 'package:flutter/foundation.dart' show immutable;
import 'package:addis_weather_v2/models/weather_common.dart';

@immutable
class HourlyWeather {
  final String cod;
  final int message;
  final int cnt;
  final List<WeatherEntry> list;
  final City? city;

  const HourlyWeather({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      cod: json['cod']?.toString() ?? '',
      message: json['message'] ?? 0,
      cnt: json['cnt'] ?? 0,
      list: (json['list'] as List<dynamic>? ?? [])
          .map((entry) => WeatherEntry.fromJson(entry as Map<String, dynamic>))
          .toList(),
      city: json['city'] != null
          ? City.fromJson(json['city'] as Map<String, dynamic>)
          : null,
    );
  }
}

@immutable
class WeatherEntry {
  final int dt;
  final Main main;
  final List<WeatherData> weather;
  final Wind wind;
  final int visibility;
  final dynamic pop;
  final String dtTxt;

  const WeatherEntry({
    required this.dt,
    required this.main,
    required this.wind,
    required this.weather,
    required this.visibility,
    required this.pop,
    required this.dtTxt,
  });

  factory WeatherEntry.fromJson(Map<String, dynamic> json) {
    return WeatherEntry(
      dt: json['dt'] ?? 0,
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>? ?? [])
          .map((entry) => WeatherData.fromJson(entry as Map<String, dynamic>))
          .toList(),
      wind: Wind.fromJson(json['wind'] as Map<String, dynamic>),

      visibility: json['visibility'] ?? 0,
      pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
      dtTxt: json['dt_txt'] ?? '',
    );
  }
}

class City {
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int population;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }
}
