import 'package:azan/app/services/storage_controller.dart';

class LocationKeys {
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String country = 'country';
  static const String state = 'state';
  static const String city = 'city';
}

class LocationSettings {
  final StorageController storageController;

  String _country = 'US';
  String _state = 'New York';
  String _city = 'New York City';
  double _latitude = 40.7128;
  double _longitude = -74.0060;

  LocationSettings({required this.storageController});

  // Getter and Setter for country
  String get country => _country;
  set country(String value) {
    _country = value;
    storageController.saveValue(LocationKeys.country, value);
  }

  // Getter and Setter for state
  String get state => _state;
  set state(String value) {
    _state = value;
    storageController.saveValue(LocationKeys.state, value);
  }

  // Getter and Setter for city
  String get city => _city;
  set city(String value) {
    _city = value;
    storageController.saveValue(LocationKeys.city, value);
  }

  // Getter and Setter for latitude
  double get latitude => _latitude;
  set latitude(double value) {
    _latitude = value;
    storageController.saveValue(LocationKeys.latitude, value.toString());
  }

  // Getter and Setter for longitude
  double get longitude => _longitude;
  set longitude(double value) {
    _longitude = value;
    storageController.saveValue(LocationKeys.longitude, value.toString());
  }

  // Initialize values from storage if they exist
  Future<void> initializeFromStorage() async {
    final storedCountry = await storageController.getValue(LocationKeys.country);
    if (storedCountry != null) _country = storedCountry;

    final storedState = await storageController.getValue(LocationKeys.state);
    if (storedState != null) _state = storedState;

    final storedCity = await storageController.getValue(LocationKeys.city);
    if (storedCity != null) _city = storedCity;

    final storedLatitude = await storageController.getValue(LocationKeys.latitude);
    if (storedLatitude != null) _latitude = double.tryParse(storedLatitude) ?? _latitude;

    final storedLongitude = await storageController.getValue(LocationKeys.longitude);
    if (storedLongitude != null) _longitude = double.tryParse(storedLongitude) ?? _longitude;
  }
  Future<bool> checkIfSetupRequired() async {
    final results = await Future.wait([
      storageController.getValue(LocationKeys.longitude),
      storageController.getValue(LocationKeys.latitude),
      storageController.getValue(LocationKeys.city),
    ]);
    return results.any((element) => element == null);
  }
}


