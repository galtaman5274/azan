// services/background_image_service.dart
import 'dart:async';

import 'package:flutter/material.dart';

class BackgroundImageService extends ChangeNotifier {
  final List<String> _backgroundImages = [
    'assets/images/home_1.png',
    'assets/images/home_2.png',
    'assets/images/home_3.png',
    'assets/images/home_4.png'
  ];
  int _currentImageIndex = 0;
  Timer? _imageChangeTimer;

  String get currentBackgroundImage => _backgroundImages[_currentImageIndex];

  void startImageChangeTimer() {
    _imageChangeTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
      notifyListeners();
    });
  }

  void dispose() {
    _imageChangeTimer?.cancel();
  }
}
