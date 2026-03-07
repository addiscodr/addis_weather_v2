import 'package:addis_weather_v2/constants/text_styles.dart';
import 'package:addis_weather_v2/extensions/datetime.dart';
import 'package:addis_weather_v2/models/famous_city.dart';
import 'package:addis_weather_v2/screens/home_screen.dart';
import 'package:addis_weather_v2/services/api_helper.dart';
import 'package:addis_weather_v2/views/gradient_container.dart';
import 'package:addis_weather_v2/views/hourly_forecast_view.dart';
import 'package:addis_weather_v2/views/weekly_forecast_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final TextEditingController searchController = TextEditingController();

  List<FamousCity> filteredCities = famousCities;

  FamousCity? selectedCity;

  void filterCities(String query) {
    setState(() {
      filteredCities = famousCities
          .where(
            (city) => city.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  void selectCity(FamousCity city) {
    setState(() {
      selectedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GradientContainer(
          children: [
            /// BACK BUTTON
            Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.back, color: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  ),                  
                ),
              ],
            ),

            /// TITLE
            const Align(
              alignment: Alignment.center,
              child: Text('Forecast Report', style: TextStyles.h1),
            ),

            const SizedBox(height: 20),

            /// SEARCH BAR
            TextField(
              controller: searchController,
              onChanged: filterCities,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search city...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                // ignore: deprecated_member_use
                fillColor: Colors.white.withOpacity(.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// CITY LIST
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: filteredCities.take(5).length,
                itemBuilder: (context, index) {
                  final city = filteredCities[index];

                  return ListTile(
                    title: Text(
                      city.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () => selectCity(city),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// FORECAST SECTION
            if (selectedCity != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedCity!.name, style: TextStyles.h2),
                  Text(DateTime.now().dateTime, style: TextStyles.subtitleText),
                ],
              ),

              const SizedBox(height: 20),

              /// HOURLY FORECAST
              FutureBuilder(
                future: ApiHelper.getHourlyForecastByCoords(
                  selectedCity!.lat,
                  selectedCity!.lon,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return const Text(
                      "No data available",
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  return const HourlyForecastView();
                },
              ),

              const SizedBox(height: 30),

              /// WEEKLY TITLE
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Next Forecast', style: TextStyles.h2),
                  Icon(Icons.calendar_month_outlined, color: Colors.white),
                ],
              ),

              const SizedBox(height: 20),

              /// WEEKLY FORECAST
              FutureBuilder(
                future: ApiHelper.getWeeklyForecastByCoords(
                  selectedCity!.lat,
                  selectedCity!.lon,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return const Text(
                      "No weekly data",
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  return SizedBox(height: 300, child: WeeklyForecastView());
                },
              ),
            ],

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
