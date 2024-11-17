import 'dart:convert';
import 'dart:io';

import '../../domain/qari.dart';

abstract class QariFileHandler {
  Future<List<Qari>> readFromFile(String filePath);
  Future<void> writeToFile(String filePath, List<Qari> qariList);
}

class QariFileHandlerImpl implements QariFileHandler {
  @override
  Future<List<Qari>> readFromFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);
      return jsonData.map((json) => Qari.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> writeToFile(String filePath, List<Qari> qariList) async {
    final file = File(filePath);
    final List<Map<String, dynamic>> jsonData = qariList.map((qari) => qari.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonData));
  }
}
