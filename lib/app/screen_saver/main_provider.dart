import 'package:flutter/material.dart';

import 'controller.dart';

// Navigation Provider
class NavigationProvider extends ChangeNotifier {
  String _currentScreen = 'home';
  bool _showScreenSaver = false;
  ScreenSaverController? screenSaverController;

  String get currentScreen => _currentScreen;
  bool get showScreenSaver => _showScreenSaver;
  void updateImages(List<String> newImages) {
    screenSaverController?.updateImages(newImages);
    notifyListeners(); // Notify listeners of the new image list
  }

  void initScreenSaverController(List<String> images, TickerProvider vsync) {
    if (screenSaverController != null) {
      screenSaverController!.dispose();
    }
    screenSaverController = ScreenSaverController(
      images: images,
      vsync: vsync,
      onShowScreenSaver: () {
        _showScreenSaver = true;
        notifyListeners();
      },
      onHideScreenSaver: () {
        _showScreenSaver = false;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  void navigateTo(String screen) {
    _currentScreen = screen;
    _showScreenSaver = false;
    notifyListeners();
  }

  void toggleScreenSaver(bool show) {
    _showScreenSaver = show;
    notifyListeners();
  }

  @override
  void dispose() {
    screenSaverController?.dispose();
    super.dispose();
  }
}
