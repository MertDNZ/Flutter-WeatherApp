class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  Weather.fromJson(Map<String, dynamic> json)
      : cityName = json['name'],
        temperature = json['main']['temp'].toDouble(),
        mainCondition = json['weather'][0]['main'];
}
