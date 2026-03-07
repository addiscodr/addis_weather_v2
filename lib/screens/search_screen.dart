import 'package:addis_weather_v2/constants/text_styles.dart';
import 'package:addis_weather_v2/screens/home_screen.dart';
import 'package:addis_weather_v2/models/famous_city.dart';
import 'package:addis_weather_v2/views/famous_cities_view.dart';
import 'package:addis_weather_v2/views/gradient_container.dart';
import 'package:addis_weather_v2/widgets/round_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _controller;

  List<FamousCity> filteredCities = famousCities;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();

    _controller.addListener(_filterCities);
  }

  void _filterCities() {
    final query = _controller.text.toLowerCase();

    final results = famousCities.where((city) {
      return city.name.toLowerCase().contains(query);
    }).toList();

    setState(() {
      filteredCities = results;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_filterCities);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Pick Location', style: TextStyles.h1),
              SizedBox(height: 30),
              Text(
                'Find the area or city that you want to know the detailed weather info at this time.',
                style: TextStyles.subtitleText,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(child: RoundTextField(controller: _controller)),
            ],
          ),
          const SizedBox(height: 30),

          Expanded(child: FamousCitiesView(cities: filteredCities)),
        ],
      ),
    );
  }
}
