import 'package:flutter/material.dart';
import 'package:open_weather_demo/controllers/splash_screen_controller.dart';
import 'package:open_weather_demo/models/city_selection.dart';
import 'package:open_weather_demo/screeens/weather_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserLocationController>().getLocation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserLocationController>(
        builder: (context, controller, child) {
          if (controller.state == UserLocationStates.error) {
            return Center(
              child: Text(controller.errorMessage ?? ''),
            );
          }

          if (controller.state == UserLocationStates.loaded) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _setCurrentLocation(controller.lat, controller.lng);
              _goToWeatherScreen();
            });
            return const Center(
              child: Text('Location Loaded Successfully'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _setCurrentLocation(double? lat, double? lng) {
    context.read<CitySelectionController>().availableCities =
        City(name: 'Current', lat: lat!, lng: lng!);
    context.read<CitySelectionController>().selectCity(0);
  }

  void _goToWeatherScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WeatherScreen(),
    ));
  }
}
