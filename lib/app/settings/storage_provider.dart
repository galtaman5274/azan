import 'package:adhan/adhan.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String calculationMethod = 'calculationMethod';
  static const String asrMethod = 'asrMethod';
  static const String country = 'country';

  static const String state = 'state';

  static const String city = 'city';
    static const String fajr = 'fajr';
  static const String tulu = 'tulu';
  static const String dhuhr = 'dhuhr';
  static const String asr = 'asr';

  static const String magrib = 'magrib';

  static const String isha = 'isha';
}

class StorageController {
  final FlutterSecureStorage _storage;
  StorageController(this._storage);

  Future<void> saveValue(String key, String value) async =>
      await _storage.write(key: key, value: value);

  Future<String?> getValue(String key) async => await _storage.read(key: key);

  Future<void> saveSettings({
    required String latitude,
    required String longitude,
    required CalculationMethod calculationMethod,
    required Madhab asrMethod,
    required String country,
    required String state,
    required String city
  }) async {
    saveValue(StorageKeys.latitude, latitude);
    saveValue(StorageKeys.longitude, longitude);
    saveValue(StorageKeys.calculationMethod, calculationMethod.name);
    saveValue(StorageKeys.asrMethod, asrMethod.name);
    saveValue(StorageKeys.country, country);
    saveValue(StorageKeys.state, state);
    saveValue(StorageKeys.city, city);

  }

  Future<bool> checkIfSetupRequired() async {
    final results = await Future.wait([
      getValue(StorageKeys.longitude),
      getValue(StorageKeys.calculationMethod),
      getValue(StorageKeys.city),
    ]);
    return results.any((element) => element == null);
  }
Future<Map<String, String?>> loadLocationSettings() async {
    final country =await getValue(StorageKeys.country);
    final state = await getValue(StorageKeys.state);
    final city =
 await       getValue(StorageKeys.city);

    return {
      StorageKeys.country: country,
      StorageKeys.state: state,
      StorageKeys.city: city,
    };
  }
  Future<Map<String, String?>> loadSettingsForPrayer() async {
    final latitude =await getValue(StorageKeys.latitude);
    final longitude = await getValue(StorageKeys.longitude);
    final calculationMethod = await  getValue(StorageKeys.calculationMethod);
    final asrMethod = await getValue(StorageKeys.asrMethod);
final fajr =await getValue(StorageKeys.fajr);
    final tulu = await getValue(StorageKeys.tulu);
    final dhuhr = await  getValue(StorageKeys.dhuhr);
    final asr = await getValue(StorageKeys.asr);
    final magrib =await getValue(StorageKeys.magrib);
    final isha = await getValue(StorageKeys.isha);

    return {
      StorageKeys.latitude: latitude,
      StorageKeys.longitude: longitude,
      StorageKeys.calculationMethod: calculationMethod,
      StorageKeys.asrMethod: asrMethod,
       StorageKeys.fajr: fajr,
      StorageKeys.tulu: tulu,
      StorageKeys.dhuhr: dhuhr,
      StorageKeys.asr: asr,
       StorageKeys.magrib: magrib,
      StorageKeys.isha: isha,

    };
  }
}
