import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utilities/theme/dark_mode.dart';
import 'package:weather_app/utilities/theme/light_mode.dart';
import 'package:weather_app/views/weather_view.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => WeatherProvider(WeatherService())),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      title: 'Weather App',
      home: const WeatherView(),
    );
  }
}
