import 'package:flutter/material.dart';
import 'package:open_weather_demo/configs/api_configs.dart';
import 'package:open_weather_demo/controllers/weather_data_controller.dart';
import 'package:open_weather_demo/models/weather_data_model.dart';
import 'package:open_weather_demo/utils/date_format_extension.dart';
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CitySelectionDropDown(),
          )
        ],
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
                  controller.data!.main!.getMinTempInCelcius() ?? 0,
                  controller.data!.main!.getMaxTempInCelcius() ?? 0,
                  controller.data!.name ?? '',
                  controller.data!.weatherDetails,
                  DateTime.fromMillisecondsSinceEpoch(
                      (controller.data!.dt! * 1000).toInt()),
                  controller.data!.main!.humidity!.toInt()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _weatherData(double temp, double minTemp, double maxTemp, String cityName,
      Weather? weatherDetails, DateTime time, int humidity) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _weatherImage(weatherDetails!.icon!),
          _city(cityName),
          const SizedBox(
            height: 12,
          ),
          _temp(
            temp.toStringAsFixed(2),
          ),
          const SizedBox(
            height: 12,
          ),
          _minMaxTemp(
            minTemp.toStringAsFixed(2),
            maxTemp.toStringAsFixed(2),
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 24,
          ),
          _additionalWeatherData(time.getFormattedDate('dd MMM, yyyy'),
              time.getFormattedDate('hh:mm'), humidity)
        ],
      ),
    );
  }

  _weatherImage(String icon) {
    return Image.network(
      ApiConfigs.getImageUrl(icon),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const SizedBox(
          height: 200,
          width: 200,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const SizedBox(
          height: 200,
          width: 200,
        );
      },
      height: 200,
    );
  }

  _city(String cityName) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cityName,
            style: const TextStyle(fontSize: 30),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.navigation,
              size: 12,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  _temp(String temp) {
    return Center(
      child: Text(
        '$temp°',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
      ),
    );
  }

  _minMaxTemp(String min, String max) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: Colors.green,
            ),
            Text(
              '$min°',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_up_rounded,
              size: 20,
              color: Colors.red,
            ),
            Text(
              '$max°',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
      ],
    );
  }

  _additionalWeatherData(String date, String time, int humidity) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child:
                _additionalWeatherField('Date', date, CrossAxisAlignment.start),
          ),
          Expanded(
            child: _additionalWeatherField(
                'Time', time, CrossAxisAlignment.center),
          ),
          Expanded(
            child: _additionalWeatherField(
                'Humidity', '$humidity%', CrossAxisAlignment.end),
          ),
        ],
      ),
    );
  }

  _additionalWeatherField(
      String label, String text, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white60),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
