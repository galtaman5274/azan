import 'package:adhan/adhan.dart';
import '../app/services/storage_controller.dart';

class PrayerKeys {
  static const String calculationMethod = 'calculationMethod';
  static const String asrMethod = 'asrMethod';
  static const String fajr = 'fajr';
  static const String tulu = 'tulu';
  static const String dhuhr = 'dhuhr';
  static const String asr = 'asr';
  static const String magrib = 'magrib';
  static const String isha = 'isha';
}

class PrayerSettings {
  Map<Prayer, DateTime> prayerAdjustments = {};
  final StorageController storageController;
  // PrayerTimes prayerTimes = PrayerTimes.today(Coordinates(40.7128, -74.0060), CalculationMethod.muslim_world_league.getParameters()..madhab = Madhab.hanafi);
  PrayerTimes prayerTimes = PrayerTimes.today(
      Coordinates(40.7128, 74.0060),
      CalculationMethod.muslim_world_league.getParameters()
        ..madhab = Madhab.hanafi);

  PrayerSettings({
    required this.storageController,
  }) {
    prayerAdjustments = {
      Prayer.fajr: prayerTimes.fajr,
      Prayer.sunrise: prayerTimes.sunrise,
      Prayer.dhuhr: prayerTimes.dhuhr,
      Prayer.asr: prayerTimes.asr,
      Prayer.maghrib: prayerTimes.maghrib,
      Prayer.isha: prayerTimes.isha
    };
  }
  // Getter and Setter for calculationMethod
  CalculationMethod get calculationMethod =>
      prayerTimes.calculationParameters.method;
  set calculationMethod(CalculationMethod value) {
    prayerTimes.calculationParameters.method = value;
    storageController.saveValue(
        PrayerKeys.calculationMethod, value.index.toString());
  }

  // Getter and Setter for asrMethod
  Madhab get asrMethod => prayerTimes.calculationParameters.madhab;
  set asrMethod(Madhab value) {
    prayerTimes.calculationParameters.madhab = value;
    storageController.saveValue(PrayerKeys.asrMethod, value.index.toString());
  }

  // Getter and Setter for fajr
  int get fajr => prayerTimes.calculationParameters.adjustments.fajr;
  set fajr(int value) {
    prayerTimes.calculationParameters.adjustments.fajr = value;
    storageController.saveValue(PrayerKeys.fajr, value.toString());
  }

  // Getter and Setter for tulu
  int get tulu => prayerTimes.calculationParameters.adjustments.sunrise;
  set tulu(int value) {
    prayerTimes.calculationParameters.adjustments.sunrise = value;
    storageController.saveValue(PrayerKeys.tulu, value.toString());
  }

  // Getter and Setter for dhuhr
  int get dhuhr => prayerTimes.calculationParameters.adjustments.dhuhr;
  set dhuhr(int value) {
    prayerTimes.calculationParameters.adjustments.dhuhr = value;
    storageController.saveValue(PrayerKeys.dhuhr, value.toString());
  }

  // Getter and Setter for asr
  int get asr => prayerTimes.calculationParameters.adjustments.asr;
  set asr(int value) {
    prayerTimes.calculationParameters.adjustments.asr = value;
    storageController.saveValue(PrayerKeys.asr, value.toString());
  }

  // Getter and Setter for magrib
  int get magrib => prayerTimes.calculationParameters.adjustments.maghrib;
  set magrib(int value) {
    prayerTimes.calculationParameters.adjustments.maghrib = value;
    storageController.saveValue(PrayerKeys.magrib, value.toString());
  }

  // Getter and Setter for isha
  int get isha => prayerTimes.calculationParameters.adjustments.isha;
  set isha(int value) {
    prayerTimes.calculationParameters.adjustments.isha = value;
    storageController.saveValue(PrayerKeys.isha, value.toString());
  }

  Future<void> updateLocation(double lati, double long) async {
    prayerTimes = PrayerTimes.today(Coordinates(lati, long),
        calculationMethod.getParameters()..madhab = asrMethod);
    prayerAdjustments = {
      Prayer.fajr: prayerTimes.fajr,
      Prayer.sunrise: prayerTimes.sunrise,
      Prayer.dhuhr: prayerTimes.dhuhr,
      Prayer.asr: prayerTimes.asr,
      Prayer.maghrib: prayerTimes.maghrib,
      Prayer.isha: prayerTimes.isha
    };
  }

  // Initialize values from storage
  Future<void> initializeFromStorage() async {
    // Load calculationMethod
    final storedCalculationMethod =
        await storageController.getValue(PrayerKeys.calculationMethod);
    // if (storedCalculationMethod != null) calculationMethod = CalculationMethod.values[int.parse('1')];
    if (storedCalculationMethod != null)
      calculationMethod =
          CalculationMethod.values[int.parse(storedCalculationMethod)];
    // Load asrMethod
    final storedAsrMethod =
        await storageController.getValue(PrayerKeys.asrMethod);
    // if (storedAsrMethod != null) asrMethod = Madhab.values[int.parse('1')];
    if (storedAsrMethod != null)
      asrMethod = Madhab.values[int.parse(storedAsrMethod)];

    final latitude = await storageController.getValue('latitude');
    final longitude = await storageController.getValue('longitude');

    prayerTimes = PrayerTimes.today(
        Coordinates(double.parse(latitude as String),
            double.parse(longitude as String)),
        calculationMethod.getParameters()..madhab = asrMethod);

    // Load prayer times
    final storedFajr = await storageController.getValue(PrayerKeys.fajr);
    if (storedFajr != null) fajr = int.parse(storedFajr);
    final storedTulu = await storageController.getValue(PrayerKeys.tulu);
    if (storedTulu != null) tulu = int.parse(storedTulu);
    final storedDhuhr = await storageController.getValue(PrayerKeys.dhuhr);
    if (storedDhuhr != null) dhuhr = int.parse(storedDhuhr);
    final storedAsr = await storageController.getValue(PrayerKeys.asr);
    if (storedAsr != null) asr = int.parse(storedAsr);
    final storedMagrib = await storageController.getValue(PrayerKeys.magrib);
    if (storedMagrib != null) magrib = int.parse(storedMagrib);
    final storedIsha = await storageController.getValue(PrayerKeys.isha);
    if (storedIsha != null) isha = int.parse(storedIsha);
    prayerAdjustments = {
      Prayer.fajr:
          prayerTimes.fajr.add(Duration(minutes: int.parse(storedFajr ?? '0'))),
      Prayer.sunrise: prayerTimes.sunrise
          .add(Duration(minutes: int.parse(storedTulu ?? '0'))),
      Prayer.dhuhr: prayerTimes.dhuhr
          .add(Duration(minutes: int.parse(storedDhuhr ?? '0'))),
      Prayer.asr:
          prayerTimes.asr.add(Duration(minutes: int.parse(storedAsr ?? '0'))),
      Prayer.maghrib: prayerTimes.maghrib
          .add(Duration(minutes: int.parse(storedMagrib ?? '0'))),
      Prayer.isha:
          prayerTimes.isha.add(Duration(minutes: int.parse(storedIsha ?? '0')))
    };
  }
}
