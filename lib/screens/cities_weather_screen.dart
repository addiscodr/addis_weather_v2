import 'package:addis_weather_v2/constants/text_styles.dart';
import 'package:addis_weather_v2/models/famous_city.dart';
import 'package:addis_weather_v2/providers/get_weather_by_city_provider.dart';
import 'package:addis_weather_v2/screens/weather_screen.dart';
import 'package:addis_weather_v2/views/gradient_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CitiesWeatherScreen extends ConsumerWidget {
  const CitiesWeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GradientContainer(
        children: [
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.back, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          const Text("Cities Weather", style: TextStyles.h1),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: famousCities.length,
              itemBuilder: (context, index) {
                final city = famousCities[index];

                final weatherData = ref.watch(
                  weatherByCityNameProvider(city.name),
                );

                return weatherData.when(
                  data: (weather) {
                    return Card(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                          width: 40,
                        ),
                        title: Text(city.name),
                        subtitle: Text(weather.weather[0].description),
                        trailing: Text(
                          "${weather.main.temp.round()}°C",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                  loading: () => const ListTile(title: Text("Loading...")),
                  error: (e, _) => ListTile(
                    title: Text(city.name),
                    subtitle: const Text("Error loading weather"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
