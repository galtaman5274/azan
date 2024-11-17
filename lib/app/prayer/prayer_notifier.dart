import 'package:adhan/adhan.dart';
import 'package:azan/app/services/prayer_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../services/storage_controller.dart';

class PrayerTimesNotifier extends ChangeNotifier {
  final PrayerService _prayerService;
  final StorageController _storageController;
  PrayerService get prayerSevice => _prayerService;
  StorageController get storage => _storageController;
  Timer? _imageChangeTimer;
  Timer? _dayChangeTimer;

  final List<String> _backgroundImages = [
    'assets/images/home_1.png',
    'assets/images/home_2.png',
    'assets/images/home_3.png',
    'assets/images/home_4.png'
  ];
  int _currentImageIndex = 0;
  String get currentBackgroundImage => _backgroundImages[_currentImageIndex];
  bool get prayerTimes => _prayerService.prayerTimes == null;

  PrayerTimesNotifier(this._prayerService, this._storageController) {
    _initializeLocationAndPrayerTimes();
    _updateCurrentTimeAndTimeLeft();
    _startImageChangeTimer();
    _startDayChangeTimer();
  }

  void updatePrayerStatus() {
    _prayerService.updatePrayerStatus();

    notifyListeners();
  }

  // Method to update the current background image
  void updateBackgroundImage() {
    _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
    notifyListeners(); // Notify listeners to update the UI
  }

  // Start a timer to periodically change the background image
  void _startImageChangeTimer() {
    _imageChangeTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      updateBackgroundImage();
    });
  }

  // Start a timer to check for a new day and reset prayer times if needed
  void _startDayChangeTimer() {
    _dayChangeTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkForNewDay();
    });
  }

  // Check if a new day has started and reset prayer data if true
  void _checkForNewDay() {
    final now = DateTime.now();
    final newDate = DateFormat('MMMM d, yyyy').format(now);
    if (newDate != _prayerService.currentDate) {
      _prayerService.setCurrentTime = newDate;
      //_updatePrayerTimes();
      _prayerService.prayerPassed = [false, false, false, false, false, false];
      notifyListeners();
    }
  }

  Future<void> _initializeLocationAndPrayerTimes() async {
    // Fetch stored settings
    final settings = await _storageController.loadSettingsForPrayer();
   double latitude = 40.7128;
       if (settings['latitude'] != null && settings['longitude'] != null) {
      final latitude = double.parse(settings['latitude']!);
      final longitude = double.parse(settings['longitude']!);
      final coordinates = Coordinates(latitude, longitude);
      final params = _prayerService.calculationMethod.getParameters();
      params.madhab = _prayerService.asrMethod;
    
    }
    
      _prayerService.prayerSettings.fajr = settings[StorageKeys.fajr] ?? '0';
      _prayerService.prayerSettings.tulu = settings[StorageKeys.tulu] ?? '0';
      _prayerService.prayerSettings.dhuhr = settings[StorageKeys.dhuhr] ?? '0';
      _prayerService.prayerSettings.asr = settings[StorageKeys.asr] ?? '0';
      _prayerService.prayerSettings.magrib = settings[StorageKeys.magrib] ?? '0';
      _prayerService.prayerSettings.isha = settings[StorageKeys.isha] ?? '0';
  

    notifyListeners(); // Notify listeners after setting prayer times
  }

  String getPrayerTime(Prayer prayer) {
    // Fetch additional time adjustment for this prayer
    String additionalMinutes = getAdditionalTime(prayer);
    return _prayerService.getPrayerTime(prayer, additionalMinutes);
  }

  Map<String, String> loadAdjustments() {
    return {
      StorageKeys.fajr: _prayerService.prayerSettings.fajr,
      StorageKeys.tulu: _prayerService.prayerSettings.tulu,
      StorageKeys.dhuhr: _prayerService.prayerSettings.dhuhr,
      StorageKeys.asr: _prayerService.prayerSettings.asr,
      StorageKeys.magrib: _prayerService.prayerSettings.magrib,
      StorageKeys.isha: _prayerService.prayerSettings.isha,
    };
  }

  Future<void> saveAdjustments(Map<String, String> prayerAdjustments) async {
    print(prayerAdjustments);
    try {
      await Future.wait([
        _storageController.saveValue(
            StorageKeys.fajr, prayerAdjustments[StorageKeys.fajr] ?? '0'),
        _storageController.saveValue(
            StorageKeys.tulu, prayerAdjustments[StorageKeys.tulu] ?? '0'),
        _storageController.saveValue(
            StorageKeys.dhuhr, prayerAdjustments[StorageKeys.dhuhr] ?? '0'),
        _storageController.saveValue(
            StorageKeys.asr, prayerAdjustments[StorageKeys.asr] ?? '0'),
        _storageController.saveValue(
            StorageKeys.magrib, prayerAdjustments[StorageKeys.magrib] ?? '0'),
        _storageController.saveValue(
            StorageKeys.isha, prayerAdjustments[StorageKeys.isha] ?? '0'),
      ]);

      // Update the PrayerService settings with the new adjustments
      _prayerService.prayerSettings.fajr =
          prayerAdjustments[StorageKeys.fajr] ?? '0';
      _prayerService.prayerSettings.tulu =
          prayerAdjustments[StorageKeys.tulu] ?? '0';
      _prayerService.prayerSettings.dhuhr =
          prayerAdjustments[StorageKeys.dhuhr] ?? '0';
      _prayerService.prayerSettings.asr =
          prayerAdjustments[StorageKeys.asr] ?? '0';
      _prayerService.prayerSettings.magrib =
          prayerAdjustments[StorageKeys.magrib] ?? '0';
      _prayerService.prayerSettings.isha =
          prayerAdjustments[StorageKeys.isha] ?? '0';
      // Notify listeners after the adjustments are saved successfully
      notifyListeners();

      // Provide user feedback that the settings have been saved
      print('Prayer adjustments saved successfully');
    } catch (e) {
      print('Error saving prayer adjustments: $e');
    }
  }

  String getAdditionalTime(Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return _prayerService.prayerSettings.fajr;
      case Prayer.sunrise:
        return _prayerService.prayerSettings.tulu;
      case Prayer.dhuhr:
        return _prayerService.prayerSettings.dhuhr;
      case Prayer.asr:
        return _prayerService.prayerSettings.asr;
      case Prayer.maghrib:
        return _prayerService.prayerSettings.magrib;
      case Prayer.isha:
        return _prayerService.prayerSettings.isha;
      default:
        throw Exception();
    }
  }

  void _updateCurrentTimeAndTimeLeft() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      _prayerService.updateCurrentTimeAndTimeLeft();
      notifyListeners(); // Ensure the UI is updated
    });
  }

  @override
  void dispose() {
    _imageChangeTimer?.cancel();
    _dayChangeTimer?.cancel();
    super.dispose();
  }
}
