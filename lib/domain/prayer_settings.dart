import 'package:adhan/adhan.dart';

class PrayerSettings {
  CalculationMethod calculationMethod;
  Madhab asrMethod;
  String fajr = '0';
  String tulu = '0';
  String dhuhr = '0';
  String asr = '0';
  String magrib = '0';
  String isha = '0';

  PrayerSettings({
    this.calculationMethod = CalculationMethod.muslim_world_league,
    this.asrMethod = Madhab.hanafi,
  });
}
