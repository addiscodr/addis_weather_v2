import 'package:flutter/foundation.dart' show immutable;
import 'package:addis_weather_v2/models/weather_common.dart';

@immutable
class Weather {
  final Coord coord;
  final List<WeatherData> weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final int dt;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const Weather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.dt,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    coord: Coord.fromJson(json['coord']),
    weather: (json['weather'] as List)
        .map((e) => WeatherData.fromJson(e))
        .toList(),
    base: json['base'] ?? '',
    main: Main.fromJson(json['main']),
    visibility: json['visibility'] ?? 0,
    wind: Wind.fromJson(json['wind']),
    dt: json['dt'] ?? 0,
    timezone: json['timezone'] ?? 0,
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    cod: json['cod'] ?? 0,
  );
}
