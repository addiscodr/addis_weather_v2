import 'package:addis_weather_v2/models/famous_city.dart';
import 'package:addis_weather_v2/widgets/famous_city_tile.dart';
import 'package:flutter/material.dart';

class FamousCitiesView extends StatelessWidget {
  const FamousCitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: famousCities.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final city = famousCities[index];

        return FamousCityTile(index: index, city: city.name);
      },
    );
  }
}
