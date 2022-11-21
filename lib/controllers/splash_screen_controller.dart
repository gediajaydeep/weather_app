import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

enum UserLocationStates { loading, loaded, error }

class UserLocationController extends ChangeNotifier {
  UserLocationStates? state = UserLocationStates.loading;
  double? lat, lng;
  String? errorMessage;
  final Location location;

  UserLocationController(this.location);

  getLocation() async {
    if (!await location.serviceEnabled()) {
      setError('Service is not available');
      return;
    }
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      PermissionStatus permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setError('Can not move forward, Permission not granted for location');
        return;
      }
    }
    LocationData locationData = await location.getLocation();
    _setLocation(locationData);
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is UserLocationController &&
        state == other.state &&
        lat == other.lat &&
        lng == other.lng &&
        errorMessage == other.errorMessage;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([state, lat, lng, errorMessage]);

  void setError(String msg) {
    state = UserLocationStates.error;
    errorMessage = msg;
    notifyListeners();
  }

  void _setLocation(LocationData locationData) {
    state = UserLocationStates.loaded;
    lat = locationData.latitude;
    lng = locationData.longitude;
    notifyListeners();
  }
}
