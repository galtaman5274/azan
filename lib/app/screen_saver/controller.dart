import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../services/storage_controller.dart';

// Screen Saver Controller
class ScreenSaverController {
  List<String> images;
  final TickerProvider vsync;
  final VoidCallback onShowScreenSaver;
  final VoidCallback onHideScreenSaver;
  Timer? _inactivityTimer;
  Timer? _imageChangeTimer;
  int _animationDuration = 30;
  int _inactivityTime = 15;

  int get animationDuration => _animationDuration;
  int get inactivityTime => _inactivityTime;
  set animationDuration(int value) => _animationDuration = value;
  set inactivityTime(int value) => _inactivityTime = value;
  final StorageController storage;
  // Animation Controller
  late AnimationController _animationController;
  // Animation Variables
  late Animation<double> _currentAnimation;
  String _currentAnimationType = 'fade';
  int _currentIndex = 0;
  final Random _random = Random();
// New function to update the images list
  void updateImages(List<String> newImages) {
    images = newImages;
    _currentIndex = 0; // Reset the current index to the beginning
    _setRandomAnimation();
    _animationController.reset(); // Reset any current animation
    _startImageChange(); // Restart the image change timer if needed
  }

  Animation<double> get currentAnimation => _currentAnimation;
  String get currentAnimationType => _currentAnimationType;
  int get currentIndex => _currentIndex;

  ScreenSaverController({
    required this.storage,
    required this.images,
    required this.vsync,
    required this.onShowScreenSaver,
    required this.onHideScreenSaver,
  }) {
    init();
    _initAnimationController();
    _startInactivityTimer();
    _startImageChange();
  }
  void saveSaverSettings() {
    storage.saveValue('animationDuration', animationDuration.toString());
    storage.saveValue('inactivityTimer', inactivityTime.toString());
  }

  Future<void> init() async {
    _animationDuration =
        int.parse(await storage.getValue('animationDuration') ?? '30'); //50
    _inactivityTime =
        int.parse(await storage.getValue('inactivityTimer') ?? '15');
  }

  void _initAnimationController() async {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
    );
    _setRandomAnimation();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: _inactivityTime),
        _showSaver); // Set duration to 5 seconds for testing
  }

  void resetInactivityTimer() {
    onHideScreenSaver(); // Hide the screen saver when interaction happens
    _startInactivityTimer();
  }

  void _showSaver() {
    onShowScreenSaver(); // Update the provider to show the screen saver
    _setRandomAnimation();

    _animationController.forward(from: 0.0);
    //notifyListeners();
  }

  void _hideSaver() {
    onHideScreenSaver(); // Update the provider to hide the screen saver

    _animationController.reset();
    //notifyListeners();
  }

  void _startImageChange() {
    
    _imageChangeTimer =
        Timer.periodic(Duration(seconds: _animationDuration + 2), (timer) {
          
      if (!_animationController.isAnimating) {
        //_currentIndex = (_currentIndex + 1) % images.length;
        _setRandomAnimation();
        //_animationController.forward(from: 0.0);
        _animationController.forward(from: 0.0).whenComplete(() async {
          // Pause for a specific duration after the animation completes
          await Future.delayed(Duration(
              seconds: _animationDuration)); // Adjust pause duration here

          // Update the current image index and set a random animation
          _currentIndex = (_currentIndex + 1) % images.length;

          _setRandomAnimation();

          // Notify listeners to update the UI
          //notifyListeners();
        });
        //notifyListeners();
      }
    });
  }

  void _setRandomAnimation() {
    final int animationIndex = _random.nextInt(3);
    switch (animationIndex) {
      case 0:
        _currentAnimationType = 'fade';
        _currentAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
        break;
      case 1:
        _currentAnimationType = 'scale';
        _currentAnimation =
            Tween<double>(begin: 0.5, end: 1.0).animate(_animationController);
        break;
      case 2:
        _currentAnimationType = 'rotation';
        _currentAnimation = Tween<double>(begin: 0.0, end: 2 * pi)
            .animate(_animationController);
        break;
      default:
        _currentAnimationType = 'fade';
        _currentAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    }
  }

  void dispose() {
    _inactivityTimer?.cancel();
    _imageChangeTimer?.cancel();
    // Stop any ongoing animation before disposing of the controller
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.dispose();
  }
}
