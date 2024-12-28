import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:permission_handler/permission_handler.dart';
import '../model/audio_file_model.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    try {
      if (_db != null) return _db;

      await _requestPermissions();

      final directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, 'db');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE Favourite(id INTEGER PRIMARY KEY, name TEXT, path TEXT, size TEXT, length TEXT, isFavourite INTEGER)",
          );
        },
      );
      return _db;
    } catch (e) {
      print("Error initializing database: $e");
      return null;
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.isDenied) {
        await Permission.manageExternalStorage.request();
      }
    } else if (Platform.isIOS) {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
    }
  }

  Future<AudioFile> insert(AudioFile model) async {
    var dbClient = await db;
    await dbClient!.insert('Favourite', model.toMap());
    return model;
  }

  Future<int> delete(String name) async {
    var dbClient = await db;
    try {
      return await dbClient!.delete(
        'Favourite',
        where: 'name = ?',
        whereArgs: [name],
      );
    } catch (e) {
      print("Error deleting entry: $e");
      return 0;
    }
  }

  Future<List<AudioFile>> getData() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('Favourite');
    return queryResult.map((e) => AudioFile.fromMap(e)).toList();
  }

  Future<bool> isFavoriteExists(String name) async {
    var dbClient = await db;
    if (dbClient == null) return false;

    final List<Map<String, Object?>> queryResult = await dbClient.query(
      'Favourite',
      where: 'name = ?',
      whereArgs: [name],
    );
    return queryResult.isNotEmpty;
  }
}
