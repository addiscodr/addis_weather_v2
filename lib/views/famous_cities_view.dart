import 'package:flutter/material.dart';
import '../models/famous_city.dart';
import '../screens/weather_detail_screen.dart';

class FamousCitiesView extends StatelessWidget {
  final List<FamousCity> cities;

  const FamousCitiesView({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];

        return ListTile(
          title: Text(city.name),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherDetailScreen(cityName: city.name),
              ),
            );
          },
        );
      },
    );
  }
}
