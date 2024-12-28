import 'package:adhan/adhan.dart';
import 'package:azan/domain/general_settings.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:flutter/material.dart';
import '../../domain/location_settings.dart';

class LocationProvider extends ChangeNotifier {
  final LocationSettings _locationSettings;
  LocationProvider(this._locationSettings);
  LocationSettings get locationSettings => _locationSettings;
void init(){
  _locationSettings.initializeFromStorage().then((_)=>notifyListeners());
  //notifyListeners();
}
  void saveSettings(
      {required String latitude,
        required String longitude,

        required String country,
        required String city,
        required String state}) {
    _locationSettings.country = country;
    _locationSettings.state = state;
    _locationSettings.city = city;
    _locationSettings.longitude = double.parse(longitude);
    _locationSettings.latitude = double.parse(latitude);

    notifyListeners();
  }
}
