import 'package:adhan/adhan.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageController {
  final FlutterSecureStorage _storage ;
  StorageController(this._storage);
  Future<void> saveValue(String key, String value) async =>
      await _storage.write(key: key, value: value);

  Future<String?> getValue(String key) async => await _storage.read(key: key);

}
