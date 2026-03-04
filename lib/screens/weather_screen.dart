import 'package:addis_weather_v2/constants/text_styles.dart';
import 'package:addis_weather_v2/extensions/datetime.dart';
import 'package:addis_weather_v2/providers/current_weather_provider.dart';
import 'package:addis_weather_v2/views/gradient_container.dart';
import 'package:addis_weather_v2/views/hourly_forecast_view.dart';
import 'package:addis_weather_v2/views/weather_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(currentWeatherProvider);
    return Scaffold(
      body: SafeArea(
        child: weatherData.when(
          data: (weather) {
            return GradientContainer(
              children: [
                const SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(weather.name, style: TextStyles.h1),
                        const SizedBox(height: 20),
                        Text(
                          DateTime.now().dateTime,
                          style: TextStyles.subtitleText,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 260,
                          child: Image.asset(
                            'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(weather.weather[0].description, style: TextStyles.h2),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                WeatherInfo(weather: weather),
                const SizedBox(height: 40),

                // view hourly forecast
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Today', style: TextStyles.h2),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View full forecast'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const HourlyForecastView(),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
