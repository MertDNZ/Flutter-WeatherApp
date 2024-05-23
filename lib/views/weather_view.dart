import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'dart:developer' show log;

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

late bool isLoading;

class _WeatherViewState extends State<WeatherView> {
  String getWeatherAnimation(String? mainCondition) {
    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'lib/assets/cloudy_morning.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'lib/assets/rainy_morning.json';
      case 'clear':
        return 'lib/assets/sunny.json';
      default:
        return 'lib/assets/sunny.json';
    }
  }

  @override
  void initState() {
    Provider.of<WeatherProvider>(context, listen: false).getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _weather = Provider.of<WeatherProvider>(context).weather;
    isLoading = Provider.of<WeatherProvider>(context).isLoading;
    log(isLoading.toString());

    if (isLoading) {
      return Scaffold(
        body: Center(child: Lottie.asset('lib/assets/loading.json')),
      );
    } else {
      return Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            ),
            //city name
            Text(
              _weather?.cityName ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            // temperature
            Text(
              '${_weather?.temperature.round().toString()}°C',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _textButton(),
            )
          ]),
        ),
      );
    }
  }

  TextButton _textButton() {
    return TextButton(
      isSemanticButton: true,
      onPressed: () {
        Provider.of<WeatherProvider>(context, listen: false).getWeather();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
            (states) => Theme.of(context).colorScheme.primary),
        foregroundColor: WidgetStateProperty.resolveWith(
            (states) => Theme.of(context).colorScheme.onPrimary),
      ),
      child: Text(
        'Refresh',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
