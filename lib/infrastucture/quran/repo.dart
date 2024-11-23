import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../domain/qari.dart';

abstract class QariFileHandler {
  Future<List<Qari>> readFromFile();
  //Future<void> writeToFile(String fileName, List<Qari> qariList);
}

class QariFileHandlerImpl implements QariFileHandler {
  final qariList =[
    {
      "name": "Abdul Basit",
      "whereFrom": "Egypt",
      "description": "Famous for his melodious and powerful recitation.",
      "qariImage": "assets/qari/abdul_basit.jpeg",
      "nationalFlag": "assets/qari/egypt_flag.png"
    },
    {
      "name": "Mishary Rashid",
      "whereFrom": "Kuwait",
      "description": "Known for his emotional and clear recitation style.",
      "qariImage": "assets/qari/mishary_rashid.jpeg",
      "nationalFlag": "assets/qari/kuwait_flag.png"
    },
    {
      "name": "Saad Al-Ghamdi",
      "whereFrom": "Saudi Arabia",
      "description": "Renowned for his calming and beautiful recitation.",
      "qariImage": "assets/qari/saad_al_ghamdi.jpeg",
      "nationalFlag": "assets/qari/saudi_arabia_flag.png"
    }
  ];
  // Future<String> _getFilePath(String fileName) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return '${directory.path}/$fileName';
  // }

  @override
  Future<List<Qari>> readFromFile() async {
    try {
      // final filePath = await _getFilePath(fileName);
      // final file = File(filePath);

        //final contents = await file.readAsString();
        final List<dynamic> jsonData = qariList;
        return jsonData.map((json) => Qari.fromJson(json)).toList();

    } catch (e) {
      throw Exception('Error reading file: $e');
    }
  }

  // @override
  // Future<void> writeToFile(String fileName, List<Qari> qariList) async {
  //   try {
  //     final filePath = await _getFilePath(fileName);
  //     final file = File(filePath);
  //     final List<Map<String, dynamic>> jsonData = qariList.map((qari) => qari.toJson()).toList();
  //     await file.writeAsString(jsonEncode(jsonData));
  //   } catch (e) {
  //     throw Exception('Error writing file: $e');
  //   }
  // }
}
