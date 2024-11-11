import 'package:adhan/adhan.dart';
import 'package:azan/app/services/prayer_service.dart';
import 'package:azan/app/settings/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';


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

  Future<(String long, String lat)> getLongLat() async {
    final settings = await _storageController.loadSettings();
    return (settings['longitude'] ?? '', settings['latitude'] ?? '');
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
    final settings = await _storageController.loadSettings();

    if (settings['latitude'] != null && settings['longitude'] != null) {
      final latitude = double.parse(settings['latitude']!);
      final longitude = double.parse(settings['longitude']!);
      final coordinates = Coordinates(latitude, longitude);
      final params = _prayerService.calculationMethod.getParameters();
      params.madhab = _prayerService.asrMethod;

      _prayerService.prayerTimes = PrayerTimes.today(coordinates, params);
    }

    notifyListeners(); // Notify listeners after setting prayer times
  }

  String getPrayerTime(Prayer prayer) {
    return _prayerService.getPrayerTime(prayer);
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
