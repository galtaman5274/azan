import 'package:azan/app/services/storage_controller.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

// Navigation Provider
class NavigationProvider extends ChangeNotifier {
  String _currentScreen = 'home';
  bool _showScreenSaver = false;
  final StorageController _storage;
  NavigationProvider(this._storage);
int _animationDuration = 2;
int _inactivityTimer = 3;
void init()async{
  _animationDuration = int.parse(await _storage.getValue('animationDuration') ?? '2');//50
  _inactivityTimer = int.parse(await _storage.getValue('inactivityTimer') ?? '3');
  notifyListeners();
}
void saveSaverSettings()async{
  await _storage.saveValue('animationDuration', _animationDuration.toString());
  await _storage.saveValue('inactivityTimer', _inactivityTimer.toString());
  notifyListeners();
}
int get animationDuration => _animationDuration;
int get incativityTimer => _inactivityTimer;
set animationDuration (int duration) => _animationDuration = duration;
set incativityTimer(int timer) => _inactivityTimer = timer;
  ScreenSaverController? screenSaverController;

  String get currentScreen => _currentScreen;
  bool get showScreenSaver => _showScreenSaver;
  void updateImages(List<String> newImages) {
    screenSaverController?.updateImages(newImages);
    notifyListeners(); // Notify listeners of the new image list
  }
  void resetInactivityTimer() {
    screenSaverController?.resetInactivityTimer(_inactivityTimer);
  }
  void initScreenSaverController(List<String> images, TickerProvider vsync) {
    if (screenSaverController != null) {
      screenSaverController!.dispose();
    }
    screenSaverController = ScreenSaverController(
      inactivityTime: _inactivityTimer,
      animationDuration: _animationDuration,
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
