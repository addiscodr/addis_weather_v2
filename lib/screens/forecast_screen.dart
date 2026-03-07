import 'package:addis_weather_v2/constants/text_styles.dart';
import 'package:addis_weather_v2/extensions/datetime.dart';
import 'package:addis_weather_v2/screens/home_screen.dart';
import 'package:addis_weather_v2/views/gradient_container.dart';
import 'package:addis_weather_v2/views/hourly_forecast_view.dart';
import 'package:addis_weather_v2/views/weekly_forecast_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        children: [
          Row(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: const Icon(CupertinoIcons.back, color: Colors.white),
              ),
            ],
          ),

          const Align(
            alignment: Alignment.center,
            child: Text('Forecast Report', style: TextStyles.h1),
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Today', style: TextStyles.h2),
              Text(DateTime.now().dateTime, style: TextStyles.subtitleText),
            ],
          ),

          const SizedBox(height: 20),

          const HourlyForecastView(),

          const SizedBox(height: 30),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Next Forecast', style: TextStyles.h2),
              Icon(Icons.calendar_month_outlined, color: Colors.white),
            ],
          ),

          const SizedBox(height: 20),

          const WeeklyForecastView(),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
