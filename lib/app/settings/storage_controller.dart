import 'package:adhan/adhan.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class StorageKeys {
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String calculationMethod = 'calculationMethod';
  static const String asrMethod = 'asrMethod';
}
class StorageController {
  final FlutterSecureStorage _storage;
  StorageController(this._storage);
  Future<void> saveSettings({
    required String latitude,
    required String longitude,
    required CalculationMethod calculationMethod,
    required Madhab asrMethod,
  }) async {
    await _storage.write(key: StorageKeys.latitude, value: latitude.toString());
    await _storage.write(key: StorageKeys.longitude, value: longitude.toString());
    await _storage.write(
        key: 'calculationMethod',
        value: CalculationMethod.values.indexOf(calculationMethod).toString());
    await _storage.write(
        key: 'asrMethod', value: Madhab.values.indexOf(asrMethod).toString());
  }

  Future<bool> checkIfSetupRequired() async {
    final results = await Future.wait([
      _storage.read(key: StorageKeys.latitude),
      _storage.read(key: StorageKeys.longitude),
      _storage.read(key: StorageKeys.calculationMethod)
    ]);
    return results.any((element) => element == null);
  }

  Future<Map<String, String?>> loadSettings() async {
    final latitude = await _storage.read(key: StorageKeys.latitude);
    final longitude = await _storage.read(key: StorageKeys.longitude);
    final calculationMethod = await _storage.read(key: StorageKeys.calculationMethod);
    final asrMethod = await _storage.read(key: StorageKeys.asrMethod);

    return {
      StorageKeys.latitude: latitude,
      StorageKeys.longitude: longitude,
      StorageKeys.calculationMethod: calculationMethod,
      StorageKeys.asrMethod: asrMethod,
    };
  }
}
