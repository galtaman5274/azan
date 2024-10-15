import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class ScreenSaver extends StatefulWidget {
  const ScreenSaver({super.key});

  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver>
    with TickerProviderStateMixin {
  static const _inactivityDuration = Duration(seconds: 10); // Set the duration
  Timer? _inactivityTimer;
  bool _showScreenSaver = false;

  // List of screen saver images
  final List<String> _images = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
  ];

  // Animation Controllers
  late AnimationController _animationController;

  // Animation Variables
  late Animation<double> _currentAnimation;

  // Track the current animation type
  String _currentAnimationType = 'fade';

  int _currentIndex = 0; // Current index for images
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _startInactivityTimer();

    // Initializing Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Set the first animation randomly
    _setRandomAnimation();

    // Start Image Change Timer
    _startImageChange();
  }

  // Start inactivity timer
  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(_inactivityDuration, _showSaver);
  }

  // Reset inactivity timer on user interaction
  void _resetInactivityTimer() {
    if (_showScreenSaver) {
      _hideSaver();
    }
    _startInactivityTimer();
  }

  // Show screen saver
  void _showSaver() {
    setState(() {
      _showScreenSaver = true;
      _animationController.forward(from: 0.0);
    });
  }

  // Hide screen saver
  void _hideSaver() {
    setState(() {
      _showScreenSaver = false;
      _animationController.reset();
    });
  }

  // Start the image change cycle with random animations
  void _startImageChange() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_showScreenSaver) {
        _currentIndex = (_currentIndex + 1) % _images.length;
        _setRandomAnimation();
        _animationController.forward(from: 0.0);
        setState(() {});
      }
    });
  }

  // Set random animation based on index
  void _setRandomAnimation() {
    final int animationIndex = _random.nextInt(3); // Pick random index
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _resetInactivityTimer, // Reset timer on tap
      onPanUpdate: (_) => _resetInactivityTimer(), // Reset timer on swipe
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Screen Saver'),
        ),
        body: Stack(
          children: [
            // Normal app content
            const Center(
              child:
                  Text('Interact with the screen to prevent the screen saver'),
            ),
            // Screen Saver Overlay
            if (_showScreenSaver) _buildScreenSaver(),
          ],
        ),
      ),
    );
  }

  // Build Screen Saver Widget with random animations
  Widget _buildScreenSaver() {
    return Container(
      color: Colors.black,
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            // Apply animation based on the randomly chosen one
            Widget animatedImage = Image.asset(
              _images[_currentIndex],
              fit: BoxFit.contain,
            );

            switch (_currentAnimationType) {
              case 'scale':
                animatedImage = Transform.scale(
                  scale: _currentAnimation.value,
                  child: animatedImage,
                );
                break;
              case 'rotation':
                animatedImage = Transform.rotate(
                  angle: _currentAnimation.value,
                  child: animatedImage,
                );
                break;
              case 'fade':
              default:
                animatedImage = Opacity(
                  opacity: _currentAnimation.value,
                  child: animatedImage,
                );
                break;
            }

            return animatedImage;
          },
        ),
      ),
    );
  }
}
