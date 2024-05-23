import 'dart:convert';
import 'dart:developer' show log;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey = '344e1f9222fb5596040a20b02e61e10f';

  WeatherService();

  Future<Weather> getWeather(String cityName) async {
    final Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=tr');

    final response = await http.get(url);
    final respbody = response.body;
    log(respbody);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(respbody));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<String> getCurrentCity() async {
    // get permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // convert to location into a list of placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // extract the city name from the first placemark
    if (placemarks[0].locality.toString().isEmpty) {
      String cityName = placemarks[0].administrativeArea ?? '';
      log('Current city: $cityName');
      return cityName;
    } else {
      String cityName = placemarks[0].locality!.trim();
      log('Current city: $cityName');
      return cityName;
    }
  }
}


// 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric&lang=tr'