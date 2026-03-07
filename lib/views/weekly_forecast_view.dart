import 'package:flutter/material.dart';

class WeeklyForecastView extends StatelessWidget {
  const WeeklyForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    final days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

    return Column(
      children: days.map((day) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(day, style: const TextStyle(color: Colors.white)),
              const Text("24° / 18°", style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
