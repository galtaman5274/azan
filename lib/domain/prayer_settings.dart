import 'package:adhan/adhan.dart';

class PrayerSettings {
  String latitude;
  String longitude;
  CalculationMethod calculationMethod;
  Madhab asrMethod;

  PrayerSettings({
    required this.latitude,
    required this.longitude,
    this.calculationMethod = CalculationMethod.muslim_world_league,
    this.asrMethod = Madhab.hanafi,
  });
}