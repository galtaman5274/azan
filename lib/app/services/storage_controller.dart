import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageController {
  final FlutterSecureStorage _storage ;
  StorageController(this._storage);
  Future<void> saveValue(String key, String value) async =>
      await _storage.write(key: key, value: value);

  Future<String?> getValue(String key) async {
    // Map<String, String> value=await _storage.readAll();
    // print('app/services/storage_controller read storage----->${value}');
    return await _storage.read(key: key);}

}
