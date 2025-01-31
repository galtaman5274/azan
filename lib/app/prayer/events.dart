part of 'bloc.dart';

abstract class PrayerEvent {}

class InitializePrayerTimes extends PrayerEvent {}

class UpdatePrayerTimes extends PrayerEvent {
  final double latitude;
  final double longitude;

  UpdatePrayerTimes({required this.latitude, required this.longitude});
}

class UpdatePrayerAdjustments extends PrayerEvent {
  final Map<String, String> prayerAdjustments;

  UpdatePrayerAdjustments({required this.prayerAdjustments});
}

class PlayAdhan extends PrayerEvent {}

class UpdateBackgroundImage extends PrayerEvent {}

class CheckForNewDay extends PrayerEvent {}