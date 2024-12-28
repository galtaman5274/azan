import 'package:adhan/adhan.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../services/audio_service.dart';

class PrayerTimesNotifier extends ChangeNotifier {
  final PrayerSettings prayerSettings;
  Timer? _imageChangeTimer;
  Timer? _dayChangeTimer;
  final AdhanAudioService _adhanAudioService;
  String _currentTime = '';
  String _currentDate = '';
  String _timeLeftForNextPrayer = '';
  String get currentTime => _currentTime;
  String get currentDate => _currentDate;
  set setCurrentTime(String time) => _currentTime = time;
  set setCurrentDate(String date) => _currentDate = date;
  String get timeLeftForNextPrayer => _timeLeftForNextPrayer;
  List<bool> prayerPassed = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha
  final List<String> _backgroundImages = [
    'assets/images/home_1.png',
    'assets/images/home_2.png',
    'assets/images/home_3.png',
    'assets/images/home_4.png'
  ];
  int _currentImageIndex = 0;
  String get currentBackgroundImage => _backgroundImages[_currentImageIndex];

  PrayerTimesNotifier(this.prayerSettings, this._adhanAudioService) {
    updateCurrentTimeAndTimeLeft();
    _startImageChangeTimer();
    _startDayChangeTimer();
  }
  Future<void> _playAdhan() async {
    try {
      await _adhanAudioService.playAdhan();
    } catch (e) {
      print("Error playing Adhan audio: $e");
    }
  }

  String getPrayerTime(Prayer prayer) {
    // if (prayerSettings.prayerTimes == null) return '';

    // Parse the minutes from the input string
    // int additionalMinutes = int.tryParse(minutes) ?? 0;

    // Get the prayer time
    final DateTime time = prayerSettings.prayerAdjustments[prayer] as DateTime;
    // Add the additional minutes to the prayer time
    // final DateTime adjustedTime =
    // time.add(Duration(minutes: additionalMinutes));
    // Format the adjusted time and return as string
    return DateFormat.Hm().format(time);
  }

  void updatePrayerStatus() {
    final now = DateTime.now();
    final prayerTimesList = [
      prayerSettings.prayerTimes.fajr,
      prayerSettings.prayerTimes.sunrise,
      prayerSettings.prayerTimes.dhuhr,
      prayerSettings.prayerTimes.asr,
      prayerSettings.prayerTimes.maghrib,
      prayerSettings.prayerTimes.isha
    ];

    for (int i = 0; i < prayerTimesList.length; i++) {
      // Check if current time matches a prayer time exactly
      if (now.isAtSameMomentAs(prayerTimesList[i])) {
        if (!prayerPassed[i]) {
          // Play Adhan only if it's the first time reaching this prayer
          _playAdhan();
          prayerPassed[i] = true;
        }
      }

      // Reset the status for prayers yet to come
      if (prayerTimesList[i].isAfter(now)) {
        prayerPassed[i] = false;
      }
    }
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
    if (newDate != currentDate) {
      setCurrentTime = newDate;
      //_updatePrayerTimes();
      prayerPassed = [false, false, false, false, false, false];
      notifyListeners();
    }
  }

  DateTime? getNextPrayerTime(DateTime now) {
    //if (prayerSettings.prayerTimes == null) return null;

    final prayerTimesList = [
      prayerSettings.prayerTimes.fajr,
      prayerSettings.prayerTimes.sunrise,
      prayerSettings.prayerTimes.dhuhr,
      prayerSettings.prayerTimes.asr,
      prayerSettings.prayerTimes.maghrib,
      prayerSettings.prayerTimes.isha
    ];

    for (var prayerTime in prayerTimesList) {
      if (prayerTime.isAfter(now)) {
        return prayerTime;
      }
    }
    return null;
  }

  void updateCurrentTimeAndTimeLeft() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      _currentTime = DateFormat('HH:mm').format(now);
      _currentDate = DateFormat('MMMM d, yyyy').format(now);

      final upcomingPrayerTime = getNextPrayerTime(now);

      if (upcomingPrayerTime != null) {
        // Calculate remaining time for the next prayer
        final remainingDuration = upcomingPrayerTime.difference(now);
        _timeLeftForNextPrayer = _formatDuration(remainingDuration);
      } else {
        // Handle case where all prayers for the day have passed
        _timeLeftForNextPrayer = _calculateTimeToNextFajr(now);
      }

      updatePrayerStatus();
      notifyListeners(); // Ensure the UI is updated
    });
  }

  String _calculateTimeToNextFajr(DateTime now) {
    //if (prayerSettings.prayerTimes == null) return "00:00:00";

    final tomorrow = now.add(const Duration(days: 1));
    final nextDayPrayerTimes = PrayerTimes(
      prayerSettings.prayerTimes.coordinates,
      DateComponents(tomorrow.year, tomorrow.month, tomorrow.day),
      prayerSettings.prayerTimes.calculationParameters,
    );

    final nextFajrTime = nextDayPrayerTimes.fajr;
    final remainingDuration = nextFajrTime.difference(now);

    return _formatDuration(remainingDuration);
  }

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }

  @override
  void dispose() {
    _imageChangeTimer?.cancel();
    _dayChangeTimer?.cancel();
    super.dispose();
  }

  void saveSettings({
    required CalculationMethod caluculationMethods,
    required Madhab madhab,
  }) {
    prayerSettings.calculationMethod = caluculationMethods;
    prayerSettings.asrMethod = madhab;
    notifyListeners();
  }

  void init() {
    prayerSettings.initializeFromStorage().then((_) => notifyListeners());
  }

  void updatePrayer(double lati, double long) {
    prayerSettings.updateLocation(lati, long).then((_) => notifyListeners());
  }

  Future<void> saveAdjustments(Map<String, String> prayerAdjustments) async {
    print('app/prayer/prayer_notifier read storage ${prayerSettings.tulu}');
    //   if(prayerSettings.fajr != 0){
    //     prayerSettings.fajr=0;
    //     prayerSettings.fajr=int.parse(prayerAdjustments['fajr']!); }else
    //  {prayerSettings.fajr = int.parse(prayerAdjustments['fajr'] ?? '0');}
    prayerSettings.fajr = (prayerSettings.fajr != 0 ? 0 : prayerSettings.fajr);
    prayerSettings.fajr = int.parse(prayerAdjustments['fajr'] ?? '0');

    prayerSettings.tulu = (prayerSettings.tulu != 0 ? 0 : prayerSettings.tulu);
    prayerSettings.tulu = int.parse(prayerAdjustments['tulu'] ?? '0');

    prayerSettings.dhuhr =
        (prayerSettings.dhuhr != 0 ? 0 : prayerSettings.dhuhr);
    prayerSettings.dhuhr = int.parse(prayerAdjustments['dhuhr'] ?? '0');

    prayerSettings.asr = (prayerSettings.asr != 0 ? 0 : prayerSettings.asr);
    prayerSettings.asr = int.parse(prayerAdjustments['asr'] ?? '0');

    prayerSettings.magrib =
        (prayerSettings.magrib != 0 ? 0 : prayerSettings.magrib);
    prayerSettings.magrib = int.parse(prayerAdjustments['magrib'] ?? '0');

    prayerSettings.isha = (prayerSettings.isha != 0 ? 0 : prayerSettings.isha);
    prayerSettings.isha = int.parse(prayerAdjustments['isha'] ?? '0');

    prayerSettings.initializeFromStorage().then((_) => notifyListeners());
  }
}
