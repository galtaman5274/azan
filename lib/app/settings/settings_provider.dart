// providers/setup_provider.dart
import 'package:adhan/adhan.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:azan/app/services/audio_service.dart';
import 'package:azan/app/settings/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries_state;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/location_settings.dart';
import '../services/location_service.dart';
import '../services/prayer_service.dart';

class SetupProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService(LocationSettings());
  final PrayerService _prayerService =
      PrayerService(AdhanAudioService(AudioPlayer()));
  final StorageController _storage =
      StorageController(const FlutterSecureStorage());

  SetupProvider();
  StorageController get storage => _storage;
  LocationService get locationService => _locationService;

  void saveSettings(
      {required String latitude,
      required String longitude,
      required CalculationMethod selectedCalculationMethod,
      required int asrMethodIndex,
      required String country,
      required String city}) {
    locationService.locationSettings.country = country;
    locationService.locationSettings.city = city;
    storage.saveSettings(
        latitude: latitude,
        longitude: longitude,
        calculationMethod: selectedCalculationMethod,
        asrMethod: Madhab.values[asrMethodIndex]);
    notifyListeners();
  }
}
