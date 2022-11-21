import 'package:flutter/material.dart';
import 'package:open_weather_demo/controllers/weather_data_controller.dart';
import 'package:open_weather_demo/widgets/city_selection_dropdown.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WeatherScreenState();
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: const [CitySelectionDropDown()],
      ),
      body: Consumer<WeatherDataController>(
        builder: (context, controller, child) {
          if (controller.state == WeatherDataState.error) {
            return Center(
              child: Text(controller.errorMessage ?? ''),
            );
          }
          if (controller.state == WeatherDataState.successful) {
            return Center(
              child: _weatherData(
                  controller.data!.main!.getTempInCelcius() ?? 0,
                  controller.data!.name ?? ''),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _weatherData(double temp, String cityName) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text('Temperature in $cityName is'),
          const SizedBox(
            height: 12,
          ),
          Text('${temp.toStringAsFixed(2)}°')
        ],
      ),
    );
  }
}
