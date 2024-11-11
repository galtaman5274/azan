part of 'main_layout.dart';

class Images {
  // List of screen saver images
  static const List<String> _imagesEn = [
    'assets/images/azan_bg.jpg',
    'assets/images/cf5.png',
    'assets/images/sleep.jpg',
  ];

  static List<String> getImages(Locale locale) {
    switch (locale) {
      default:
        return _imagesEn;
    }
  }
}
