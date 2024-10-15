import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'dart:async';

// Prayer Times Notifier for Managing State
class PrayerTimesNotifier extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  PrayerTimes? prayerTimes;
  String _currentTime = '';
  String _timeLeftForNextPrayer = '';
  String city = '';
  String country = '';

  String get currentTime => _currentTime;
  String get timeLeftForNextPrayer => _timeLeftForNextPrayer;

  PrayerTimesNotifier() {
    _initializeLocationAndPrayerTimes();
    _updateCurrentTimeAndTimeLeft();
  }

  Future<void> _initializeLocationAndPrayerTimes() async {
    await _updatePrayerTimes();
  }

  // Detect the current location using geolocator and reverse geocode to get city and country
  Future<void> _detectLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return; // Handle permission denial
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();

    // Save the coordinates in Flutter Secure Storage
    await _storage.write(key: 'latitude', value: position.latitude.toString());
    await _storage.write(
        key: 'longitude', value: position.longitude.toString());

    // Reverse geocode to get city and country name
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      city = place.locality ?? '';
      country = place.country ?? '';
    }

    notifyListeners();
  }

  // Calculate prayer times based on coordinates
  Future<void> _updatePrayerTimes() async {
    final String? latitudeStr = await _storage.read(key: 'latitude');
    final String? longitudeStr = await _storage.read(key: 'longitude');

    if (latitudeStr != null && longitudeStr != null) {
      final double latitude = double.parse(latitudeStr);
      final double longitude = double.parse(longitudeStr);

      final coordinates = Coordinates(latitude, longitude);
      final params = CalculationMethod.muslim_world_league.getParameters();
      params.madhab = Madhab.hanafi;

      prayerTimes = PrayerTimes.today(coordinates, params);
    }
    notifyListeners();
  }

  // Get a formatted prayer time
  String getPrayerTime(Prayer prayer) {
    if (prayerTimes == null) return '';
    final DateTime time = prayerTimes!.timeForPrayer(prayer)!;
    return DateFormat.Hm().format(time);
  }

  // Update Current Time and Remaining Time for Next Prayer
  void _updateCurrentTimeAndTimeLeft() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      _currentTime = DateFormat('HH:mm').format(now);

      final upcomingPrayerTime = _getNextPrayerTime(now);
      if (upcomingPrayerTime != null) {
        final remainingDuration = upcomingPrayerTime.difference(now);
        _timeLeftForNextPrayer = _formatDuration(remainingDuration);
      } else {
        _timeLeftForNextPrayer = "00:00:00"; // No upcoming prayer
      }

      notifyListeners();
    });
  }

  // Get the DateTime of the next prayer
  DateTime? _getNextPrayerTime(DateTime now) {
    if (prayerTimes == null) return null;

    final prayerTimesList = [
      prayerTimes!.fajr,
      prayerTimes!.sunrise,
      prayerTimes!.dhuhr,
      prayerTimes!.asr,
      prayerTimes!.maghrib,
      prayerTimes!.isha
    ];

    for (var prayerTime in prayerTimesList) {
      if (prayerTime.isAfter(now)) {
        return prayerTime;
      }
    }
    return null;
  }

  // Format duration to HH:mm:ss
  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }
}
