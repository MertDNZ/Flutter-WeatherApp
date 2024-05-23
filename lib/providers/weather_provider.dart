import 'dart:core';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService service;
  Weather? weather;
  late bool isLoading;

  WeatherProvider(this.service);

  Future<void> getWeather() async {
    try {
      isLoading = true;
      notifyListeners();
      final cityName = await service.getCurrentCity();
      final currentWeather = await service.getWeather(cityName);
      weather = currentWeather;
      print(weather?.temperature.toString());
      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      // Handle the exception appropriately (e.g., log error, show error message)
      print('Error fetching weather: $e');
    }
  }
}
