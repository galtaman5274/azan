// providers/setup_provider.dart
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import '../../app.dart';
import '../../domain/location_settings.dart';
import '../services/location_service.dart';
import '../services/storage_controller.dart';

class SetupProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService(LocationSettings());
  final StorageController _storage;
  SetupProvider(this._storage) {
    _initializeLocations();
  }
  StorageController get storage => _storage;
  LocationService get locationService => _locationService;
  Future<void> _initializeLocations() async {
    // Fetch stored settings
    final settings = await storage.loadLocationSettings();

    if (settings['country'] != null && settings['city'] != null) {
      final country = settings['country'];
      final state = settings['state'];

      final city = settings['city'];
      locationService.locationSettings.country = country;
      locationService.locationSettings.city = city;
      locationService.locationSettings.state = state;
    }

    notifyListeners();
  }

  void changeLocale(BuildContext context, Locale newLocale) {
    App.of(context)?.setLocale(newLocale);
    notifyListeners();
  }

  void saveSettings(
      {required String latitude,
      required String longitude,
      required CalculationMethod selectedCalculationMethod,
      required int asrMethodIndex,
      required String country,
      required String city,
      required String state}) {
    locationService.locationSettings.country = country;
    locationService.locationSettings.city = city;
    storage.saveSettings(
        country: country,
        state: state,
        city: city,
        latitude: latitude,
        longitude: longitude,
        calculationMethod: selectedCalculationMethod,
        asrMethod: Madhab.values[asrMethodIndex]);
    notifyListeners();
  }
}
