import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// Screen Saver Controller
class ScreenSaverController extends ChangeNotifier {
  final List<String> images;
  final TickerProvider vsync;
  final VoidCallback onShowScreenSaver;
  final VoidCallback onHideScreenSaver;
  Timer? _inactivityTimer;
  Timer? _imageChangeTimer;

  // Animation Controller
  late AnimationController _animationController;

  // Animation Variables
  late Animation<double> _currentAnimation;

  String _currentAnimationType = 'fade';
  int _currentIndex = 0;
  final Random _random = Random();

  Animation<double> get currentAnimation => _currentAnimation;
  String get currentAnimationType => _currentAnimationType;
  int get currentIndex => _currentIndex;

  ScreenSaverController({
    required this.images,
    required this.vsync,
    required this.onShowScreenSaver,
    required this.onHideScreenSaver,
  }) {
    _initAnimationController();
    _startInactivityTimer();
    _startImageChange();
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 30),
    );
    _setRandomAnimation();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 50),
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
    notifyListeners();
  }

  void _hideSaver() {
    onHideScreenSaver(); // Update the provider to hide the screen saver
    _animationController.reset();
    notifyListeners();
  }

  void _startImageChange() {
    _imageChangeTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_animationController.isAnimating) {
        _currentIndex = (_currentIndex + 1) % images.length;
        _setRandomAnimation();
        _animationController.forward(from: 0.0);
        notifyListeners();
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

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    _imageChangeTimer?.cancel();
      // Stop any ongoing animation before disposing of the controller
  if (_animationController.isAnimating) {
    _animationController.stop();
  }
    _animationController.dispose();
    super.dispose();
  }
}
