import 'package:flutter/material.dart';
import '../app/services/storage_controller.dart';

class GeneralKeys {
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String country = 'country';
  static const String state = 'state';
  static const String city = 'city';
}

class GeneralSettings {
  final StorageController storageController;
  Locale locale = const Locale('en');
  int currentIndex = 0;


  GeneralSettings({required this.storageController});
}


