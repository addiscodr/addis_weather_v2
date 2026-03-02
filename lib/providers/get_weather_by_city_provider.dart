import 'package:addis_weather_v2/models/weather.dart';
import 'package:addis_weather_v2/services/api_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherByCityNameProvider = FutureProvider.autoDispose
    .family<Weather, String>((ref, String cityName) async {
      return ApiHelper.getWeatherByCityName(cityName: cityName);
    });
