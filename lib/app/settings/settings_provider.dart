import 'package:adhan/adhan.dart';
import 'package:azan/domain/general_settings.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:flutter/material.dart';
import '../../domain/location_settings.dart';

class SetupProvider extends ChangeNotifier {
  final LocationSettings _locationSettings;
  final GeneralSettings _generalSettings;

  void setCurrentIndex (int index){
    _generalSettings.currentIndex = index;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    _generalSettings.locale = locale;
    notifyListeners();
  }
  SetupProvider(this._locationSettings,this._generalSettings);

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
