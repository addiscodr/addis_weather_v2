import 'package:addis_weather_v2/services/api_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hourlyWeatherProvider = FutureProvider.autoDispose((ref) async {
  return ApiHelper.getHourlyForecast();
});
