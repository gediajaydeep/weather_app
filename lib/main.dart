import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:open_weather_demo/configs/api_configs.dart';
import 'package:open_weather_demo/controllers/splash_screen_controller.dart';
import 'package:open_weather_demo/models/city_selection.dart';
import 'package:open_weather_demo/controllers/weather_data_controller.dart';
import 'package:open_weather_demo/repositories/weather_repository.dart';
import 'package:open_weather_demo/screeens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CitySelectionController(),
        ),
        ChangeNotifierProxyProvider<CitySelectionController,
            WeatherDataController>(
          create: (context) =>
              WeatherDataController(_createWeatherRepository()),
          update: (context, value, previous) {
            if (previous == null) {
              throw ArgumentError.notNull('weather data controller');
            }
            if (value.selectedCity != null) {
              previous.setLocation(
                  value.selectedCity!.lat, value.selectedCity!.lng);
              previous.loadWeatherDetailsForCurrentLocations();
            }
            return previous;
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
            create: (context) => UserLocationController(_getLocation()),
            child: const SplashScreen()),
      ),
    );
  }

  WeatherRepository _createWeatherRepository() {
    return WeatherRepository(
        Client(), ApiConfigs.weatherUrl, ApiConfigs.apiKey);
  }

  Location _getLocation() {
    return Location();
  }
}
