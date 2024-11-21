import 'package:adhan/adhan.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../services/audio_service.dart';

class PrayerService {
  final AdhanAudioService _adhanAudioService;
  String _currentTime = '';
  String _currentDate = '';
  String _timeLeftForNextPrayer = '';
  final PrayerSettings prayerSettings = PrayerSettings();
  Madhab asrMethod = Madhab.hanafi;
  CalculationMethod calculationMethod = CalculationMethod.muslim_world_league;
  PrayerTimes? prayerTimes;
  final List<String> asrCalculationMethods = ['Asri-Sani', 'Asri-Evvel'];
  String asrText = 'Asri-Sani';
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

  PrayerService(this._adhanAudioService) {
    updateCurrentTimeAndTimeLeft();
  }

  // void updatePrayerStatus() {
  //   if (prayerTimes != null) {
  //     final now = DateTime.now();
  //     final prayerTimesList = [
  //       prayerTimes!.fajr,
  //       prayerTimes!.sunrise,
  //       prayerTimes!.dhuhr,
  //       prayerTimes!.asr,
  //       prayerTimes!.maghrib,
  //       prayerTimes!.isha
  //     ];
  //
  //     for (int i = 0; i < prayerTimesList.length; i++) {
  //       if (prayerTimesList[i].isBefore(now)) {
  //         if (!prayerPassed[i]) {
  //           // If it's the first time passing the prayer, play the Adhan
  //           _playAdhan();
  //         }
  //         prayerPassed[i] = true;
  //       } else {
  //         prayerPassed[i] = false;
  //       }
  //     }
  //   }
  // }

  // Play the Adhan audio
  Future<void> _playAdhan() async {
    try {
      await _adhanAudioService.playAdhan();
    } catch (e) {
      print("Error playing Adhan audio: $e");
    }
  }

  String getPrayerTime(Prayer prayer, String minutes) {
    if (prayerTimes == null) return '';

    // Parse the minutes from the input string
    int additionalMinutes = int.tryParse(minutes) ?? 0;

    // Get the prayer time
    final DateTime time = prayerTimes!.timeForPrayer(prayer)!;
    // Add the additional minutes to the prayer time
    final DateTime adjustedTime =
        time.add(Duration(minutes: additionalMinutes));
    // Format the adjusted time and return as string
    return DateFormat.Hm().format(adjustedTime);
  }

  // void updateCurrentTimeAndTimeLeft() {
  //   final now = DateTime.now();
  //   _currentTime = DateFormat('HH:mm').format(now);
  //   _currentDate = DateFormat('MMMM d, yyyy').format(now);
  //   final upcomingPrayerTime = getNextPrayerTime(now);
  //
  //   if (upcomingPrayerTime != null) {
  //     final remainingDuration = upcomingPrayerTime.difference(now);
  //     _timeLeftForNextPrayer = _formatDuration(remainingDuration);
  //   } else {
  //     _timeLeftForNextPrayer = "00:00:00";
  //   }
  //
  //   updatePrayerStatus();
  // }

  DateTime? getNextPrayerTime(DateTime now) {
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

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first.padLeft(8, "0");
  }
  void updatePrayerStatus() {
    if (prayerTimes != null) {
      final now = DateTime.now();
      final prayerTimesList = [
        prayerTimes!.fajr,
        prayerTimes!.sunrise,
        prayerTimes!.dhuhr,
        prayerTimes!.asr,
        prayerTimes!.maghrib,
        prayerTimes!.isha
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
    }
  }

  void updateCurrentTimeAndTimeLeft() {
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
  }

// Calculate time until next day's Fajr
  String _calculateTimeToNextFajr(DateTime now) {
    if (prayerTimes == null) return "00:00:00";

    final tomorrow = now.add(const Duration(days: 1));
    final nextDayPrayerTimes = PrayerTimes (
      prayerTimes!.coordinates,
      DateComponents(tomorrow.year,tomorrow.month,tomorrow.day),
      prayerTimes!.calculationParameters,
    );

    final nextFajrTime = nextDayPrayerTimes.fajr;
    final remainingDuration = nextFajrTime.difference(now);

    return _formatDuration(remainingDuration);
  }

}
