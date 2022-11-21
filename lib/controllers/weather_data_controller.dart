import 'package:flutter/foundation.dart';
import 'package:open_weather_demo/models/weather_data_model.dart';
import 'package:open_weather_demo/repositories/weather_repository.dart';

enum WeatherDataState {
  loading,
  successful,
  error;
}

class WeatherDataController extends ChangeNotifier {
  final WeatherRepository repository;

  WeatherDataState state = WeatherDataState.loading;
  double? lat, lng;
  WeatherData? data;
  String? errorMessage;

  WeatherDataController(this.repository);

  void setLocation(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }

  Future<void> loadWeatherDetailsForCurrentLocations() async {
    if (lat != null && lng != null) {
      try {
        setLoading();
        WeatherData data = await repository.getWeatherData(lat!, lng!);
        setWeatherData(data);
      } catch (e) {
        setError(e.toString());
      }
    }
  }

  setLoading() {
    state = WeatherDataState.loading;
    notifyListeners();
  }

  setError(String message) {
    state = WeatherDataState.error;
    errorMessage = message;
    notifyListeners();
  }

  void setWeatherData(WeatherData data) {
    state = WeatherDataState.successful;
    this.data = data;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    return other is WeatherDataController &&
        (state == other.state &&
            lat == other.lat &&
            lng == other.lng &&
            (data == other.data) &&
            errorMessage == other.errorMessage);
  }

  @override
  int get hashCode => Object.hashAll([
        state,
        lat,
        lng,
        data,
        errorMessage,
      ]);
}
