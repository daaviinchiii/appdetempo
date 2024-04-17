import 'package:appdetempo/models/Weather_models.dart';
import 'package:flutter/material.dart';
import 'package:appdetempo/services/Weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService("f63ea0223eb82163ec7ac9988a59ea97"); // your api key
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final Weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = Weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "loading city.."),
            Text('${_weather?.temperature.round()}°C')
          ],
        ),
      ),
    );
  }
}
