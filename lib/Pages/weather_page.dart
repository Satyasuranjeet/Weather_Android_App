import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/models/weather_model.dart';

import '../service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherpageState();

}

class _WeatherpageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService(
      'e7a5d69873acf70334de38ec41be0070');
  Weather? _weather;

  _feachWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch (e) {
      print(e);
    }
  }
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json';
    switch(mainCondition.toLowerCase()){
      case 'cloud':
      case 'mist':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'smoke':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunderstrom.json';
      case 'snow':
        return 'assets/snow.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/cloud.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _feachWeather();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_pin,
              color: Colors.grey[700],
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
        Text(_weather?.cityName ?? 'Loading...',
          style: const TextStyle(fontWeight: FontWeight.bold),),
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

        Text('${_weather?.temperature.round() ?? 0}°C',
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50,fontFamily: 'Montserrat')),
        Text(_weather?.mainCondition ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
      ],
        ))
    );
}
}