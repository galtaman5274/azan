// import 'dart:async';
// import 'package:adhan/adhan.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:azan/domain/prayer_settings.dart';
// import 'package:equatable/equatable.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:intl/intl.dart';

// part 'events.dart';
// part 'states.dart';

// class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
//   Timer? _imageChangeTimer;
//   Timer? _dayChangeTimer;
//   List<bool> prayerPassed = [false, false, false, false, false, false];

//   PrayerBloc(): super(PrayerState.initial()) {
//     on<InitializePrayerTimes>(_onInitializePrayerTimes);
//     on<UpdatePrayerTimes>(_onUpdatePrayerTimes);
//     on<UpdatePrayerAdjustments>(_onUpdatePrayerAdjustments);
//     on<CheckForNewDay>(_onCheckForNewDay);

//     _startImageChangeTimer();
//     _startDayChangeTimer();
//     updateCurrentTimeAndTimeLeft();
//   }

//   void _onInitializePrayerTimes(InitializePrayerTimes event, Emitter<PrayerState> emit) async {
    
//     // emit(PrayerTimesUpdated(
//     //   currentTime: _getCurrentTime(),
//     //   currentDate: _getCurrentDate(),
//     //   timeLeftForNextPrayer: _getTimeLeftForNextPrayer(),
//     //   prayerPassed: prayerPassed,
//     //   currentBackgroundImage: _backgroundImages[_currentImageIndex],
//     // ));
//   }

//   void _onUpdatePrayerTimes(UpdatePrayerTimes event, Emitter<PrayerState> emit) async {
//     // emit(PrayerTimesUpdated(
//     //   currentTime: _getCurrentTime(),
//     //   currentDate: _getCurrentDate(),
//     //   timeLeftForNextPrayer: _getTimeLeftForNextPrayer(),
//     //   prayerPassed: prayerPassed,
//     //   currentBackgroundImage: _backgroundImages[_currentImageIndex],
//     // ));
//   }

//   void _onUpdatePrayerAdjustments(UpdatePrayerAdjustments event, Emitter<PrayerState> emit) async {
//     await saveAdjustments(event.prayerAdjustments);
//     // emit(PrayerTimesUpdated(
//     //   currentTime: _getCurrentTime(),
//     //   currentDate: _getCurrentDate(),
//     //   timeLeftForNextPrayer: _getTimeLeftForNextPrayer(),
//     //   prayerPassed: prayerPassed,
//     //   currentBackgroundImage: _backgroundImages[_currentImageIndex],
//     // ));
//   }

  

 

//   void _onCheckForNewDay(CheckForNewDay event, Emitter<PrayerState> emit) {
//     final now = DateTime.now();
//     final newDate = DateFormat('MMMM d, yyyy').format(now);
//     if (newDate != _getCurrentDate()) {
//       prayerPassed = [false, false, false, false, false, false];
//       // emit(PrayerTimesUpdated(
//       //   currentTime: _getCurrentTime(),
//       //   currentDate: newDate,
//       //   timeLeftForNextPrayer: _getTimeLeftForNextPrayer(),
//       //   prayerPassed: prayerPassed,
//       //   currentBackgroundImage: _backgroundImages[_currentImageIndex],
//       // ));
//     }
//   }

//   void _startImageChangeTimer() {
//     _imageChangeTimer = Timer.periodic(const Duration(seconds: 10), (_) {
//       add(UpdateBackgroundImage());
//     });
//   }

//   void _startDayChangeTimer() {
//     _dayChangeTimer = Timer.periodic(const Duration(minutes: 1), (_) {
//       add(CheckForNewDay());
//     });
//   }

//   void updateCurrentTimeAndTimeLeft() {
//     Timer.periodic(const Duration(seconds: 1), (_) {
//       add(InitializePrayerTimes());
//     });
//   }

//   String _getCurrentTime() => DateFormat('HH:mm').format(DateTime.now());
//   String _getCurrentDate() => DateFormat('MMMM d, yyyy').format(DateTime.now());
//   String _getTimeLeftForNextPrayer() {
//     final now = DateTime.now();
//     final upcomingPrayerTime = _getNextPrayerTime(now);
//     if (upcomingPrayerTime != null) {
//       return _formatDuration(upcomingPrayerTime.difference(now));
//     } else {
//       return _calculateTimeToNextFajr(now);
//     }
//   }

//   DateTime? _getNextPrayerTime(DateTime now) {
//     final prayerTimesList = [
//       prayerSettings.prayerTimes.fajr,
//       prayerSettings.prayerTimes.sunrise,
//       prayerSettings.prayerTimes.dhuhr,
//       prayerSettings.prayerTimes.asr,
//       prayerSettings.prayerTimes.maghrib,
//       prayerSettings.prayerTimes.isha,
//     ];

//     for (var prayerTime in prayerTimesList) {
//       if (prayerTime.isAfter(now)) {
//         return prayerTime;
//       }
//     }
//     return null;
//   }

//   String _calculateTimeToNextFajr(DateTime now) {
    
//     final tomorrow = now.add(const Duration(days: 1));
//     final nextDayPrayerTimes = PrayerTimes(
//       prayerSettings.prayerTimes.coordinates,
//       DateComponents(tomorrow.year, tomorrow.month, tomorrow.day),
//       prayerSettings.prayerTimes.calculationParameters,
//     );

//     final nextFajrTime = nextDayPrayerTimes.fajr;
//     return _formatDuration(nextFajrTime.difference(now));
//   }

//   String _formatDuration(Duration duration) {
//     return duration.toString().split('.').first.padLeft(8, "0");
//   }
// Future<void> saveAdjustments(Map<String, String> prayerAdjustments) async {
//     print('app/prayer/prayer_notifier read storage ${prayerSettings.tulu}');
//     //   if(prayerSettings.fajr != 0){
//     //     prayerSettings.fajr=0;
//     //     prayerSettings.fajr=int.parse(prayerAdjustments['fajr']!); }else
//     //  {prayerSettings.fajr = int.parse(prayerAdjustments['fajr'] ?? '0');}
//     prayerSettings.fajr = (prayerSettings.fajr != 0 ? 0 : prayerSettings.fajr);
//     prayerSettings.fajr = int.parse(prayerAdjustments['fajr'] ?? '0');

//     prayerSettings.tulu = (prayerSettings.tulu != 0 ? 0 : prayerSettings.tulu);
//     prayerSettings.tulu = int.parse(prayerAdjustments['tulu'] ?? '0');

//     prayerSettings.dhuhr =
//         (prayerSettings.dhuhr != 0 ? 0 : prayerSettings.dhuhr);
//     prayerSettings.dhuhr = int.parse(prayerAdjustments['dhuhr'] ?? '0');

//     prayerSettings.asr = (prayerSettings.asr != 0 ? 0 : prayerSettings.asr);
//     prayerSettings.asr = int.parse(prayerAdjustments['asr'] ?? '0');

//     prayerSettings.magrib =
//         (prayerSettings.magrib != 0 ? 0 : prayerSettings.magrib);
//     prayerSettings.magrib = int.parse(prayerAdjustments['magrib'] ?? '0');

//     prayerSettings.isha = (prayerSettings.isha != 0 ? 0 : prayerSettings.isha);
//     prayerSettings.isha = int.parse(prayerAdjustments['isha'] ?? '0');

//     prayerSettings.initializeFromStorage();
//   }
//   @override
//   Future<void> close() {
//     _imageChangeTimer?.cancel();
//     _dayChangeTimer?.cancel();
//     return super.close();
//   }
// }