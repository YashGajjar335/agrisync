import 'package:agrisync/screens/weather/weather_screen.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const WeatherHomeScreen())),
        child: Card(
          color: theme.secondaryContainer,
          shadowColor: theme.primaryContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/app_logo_half.JPG",
                    fit: BoxFit.cover,
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.40,
                  ),
                ),
              ),
              const Column(
                children: [
                  TextLato(
                    text: "CityName",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  TextLato(
                    text: "10",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  TextLato(text: "Gaze"),
                  TextLato(text: "another Information")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
