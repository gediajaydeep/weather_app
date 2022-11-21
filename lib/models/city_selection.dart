import 'package:flutter/foundation.dart';

class CitySelectionController extends ChangeNotifier {
  late List<City>? _availableCities;
  City? selectedCity;

  set availableCities(City city) {
    _availableCities = [city, ..._generateDefaultList()];

  }

  List<City> get availableCity => _availableCities ?? [];

  void selectCity(int index) {
    selectedCity = (_availableCities == null || _availableCities!.isEmpty)
        ? null
        : _availableCities![index];
    notifyListeners();
  }

  List<City> _generateDefaultList() {
    return [
      City(name: 'Rajkot', lat: 22.308155, lng: 70.800705),
      City(name: 'Delhi', lat: 28.644800, lng: 77.216721),
      City(name: 'Bengaluru', lat: 12.972442, lng: 77.580643),
      City(name: 'Kolkata', lat: 22.572645, lng: 88.363892),
    ];
  }

  @override
  bool operator ==(Object other) {
    return other is CitySelectionController &&
        (listEquals(_availableCities, other.availableCity) &&
            selectedCity == other.selectedCity);
  }

  @override
  int get hashCode => Object.hashAll([_availableCities, selectedCity]);
}

class City {
  final String name;
  final double lat;
  final double lng;

  City({required this.name, required this.lat, required this.lng});

  @override
  int get hashCode => Object.hashAll([name, lat, lng]);

  @override
  bool operator ==(Object other) {
    return other is City &&
        (name == other.name && lat == other.lat && lng == other.lng);
  }
}
