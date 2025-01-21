import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'data_models.dart';

class ContentProvider with ChangeNotifier {
  Alert? alerts;
  AzanFiles? azanFiles;
  Quran? quranFiles;
  ScreenSaver? screenSaver;
  final Dio _dio;
  ContentProvider(this._dio);
  final String url = 'https://app.ayine.tv/Ayine/ayine.json';
  Future<void> fetchAndStoreContent(String locale) async {
    
    try {
      // Fetch JSON data
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      final data = response.data;

      // Parse data using models
      alerts = Alert.fromJson(data['Alert']);
      azanFiles = AzanFiles.fromJson(data['AzanFiles']);

      quranFiles = Quran.fromJson(data['Quran']);
      screenSaver = ScreenSaver.fromJson(data['ScreenSaver']);
      
    } catch (error) {
      print('Error fetching data: $error');
      
    }
  }
  Future<List<String>> saveImagesToLocal(
       String locale) async {
    final images = screenSaver?.getImages(locale) ?? [];
    final List<String> savedPaths = [];

    // Get the application documents directory
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory directory =
        Directory('${appDocDir.path}/screen_savers/$locale');

    // Create the directory if it doesn't exist
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    for (final imageUrl in images) {
      final uri = Uri.parse(imageUrl);

      try {
        final response = await _dio.get(
          imageUrl,
          options:
              Options(responseType: ResponseType.bytes), // Request binary data
        );

        if (response.statusCode == 200) {
          final fileName = uri.pathSegments.last;
          final file = File('${directory.path}/$fileName');

          await file
              .writeAsBytes(response.data); // Write binary data to the file
          savedPaths.add(file.absolute.path);
          screenSaver?.saveToLocal(file.absolute.path, locale);
          print('File saved: ${file.absolute.path}');
        } else {
          print(
              'Failed to download $imageUrl. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error downloading $imageUrl: $e');
      }
    }

    return savedPaths;
  }
}
