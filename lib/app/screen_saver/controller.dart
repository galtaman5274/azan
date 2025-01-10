import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

// Screen Saver Controller
class ScreenSaverController extends ChangeNotifier {


  List<String> images;
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
    required this.images,
    required this.vsync,
    required this.onShowScreenSaver,
    required this.onHideScreenSaver,
    required int animationDuration,
    required int inactivityTime
  }) {
    _initAnimationController(animationDuration);
    _startInactivityTimer(inactivityTime);
    _startImageChange();
  }



  void _initAnimationController(int animationDuration ) {
    _animationController = AnimationController(
      vsync: vsync,
      duration:  Duration(seconds: animationDuration),
    );
    _setRandomAnimation();
  }

  void _startInactivityTimer(int inactivityTime) {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer( Duration(seconds: inactivityTime),
        _showSaver); // Set duration to 5 seconds for testing
  }

  void resetInactivityTimer(int inactivityTime) {
    onHideScreenSaver(); // Hide the screen saver when interaction happens
    _startInactivityTimer(inactivityTime);
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
    

    _imageChangeTimer =  Timer.periodic(const Duration(seconds: 10), (timer) {
      if (!_animationController.isAnimating) {
        _currentIndex = (_currentIndex + 1) % images.length;
        _setRandomAnimation();
        //_animationController.forward(from: 0.0);
        _animationController.forward(from: 0.0).whenComplete(() async {
          // Pause for a specific duration after the animation completes
          await Future.delayed(const Duration(seconds: 8)); // Adjust pause duration here

          // Update the current image index and set a random animation
          _currentIndex = (_currentIndex + 1) % images.length;
          _setRandomAnimation();

          // Notify listeners to update the UI
          notifyListeners();
        });
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
