part of 'bloc.dart';

class NavigationState extends Equatable {
  final String currentScreen;
  final bool showScreenSaver;
  final int
      animationDuration; // The time to show each image or run an animation
  final int inactivityTime; // Time before screensaver kicks in
  final List<Widget> images;
  final int currentIndex;
  final String currentAnimationType; // e.g., fade, scale, rotation
  final bool screenSaverFull;
  

  const NavigationState({
    required this.currentScreen,
    required this.showScreenSaver,
    required this.animationDuration,
    required this.inactivityTime,
    required this.images,
    required this.currentIndex,
    required this.currentAnimationType,
    required this.screenSaverFull
  });

  // Initial State
  factory NavigationState.initial() {
    return const NavigationState(
      currentScreen: 'home',
      showScreenSaver: false,
      animationDuration: 32,
      inactivityTime: 15,
      images: [ Image(image: AssetImage('assets/screen_savers/tr/1-allah.jpg'),fit: BoxFit.fill, width: double.infinity,), 
      Image(image: AssetImage('assets/screen_savers/tr/2-rahman.jpg'),fit: BoxFit.fill,width: double.infinity,)],
      currentIndex: 0,
      currentAnimationType: 'fade',
      screenSaverFull: false
    );
  }

  NavigationState copyWith({
    String? currentScreen,
    bool? showScreenSaver,
    int? animationDuration,
    int? inactivityTime,
    List<Widget>? images,
    int? currentIndex,
    String? currentAnimationType,
    bool? screenSaverFull
  }) {
    return NavigationState(
      currentScreen: currentScreen ?? this.currentScreen,
      showScreenSaver: showScreenSaver ?? this.showScreenSaver,
      animationDuration: animationDuration ?? this.animationDuration,
      inactivityTime: inactivityTime ?? this.inactivityTime,
      images: images ?? this.images,
      currentIndex: currentIndex ?? this.currentIndex,
      currentAnimationType: currentAnimationType ?? this.currentAnimationType,
      screenSaverFull: screenSaverFull ?? this.screenSaverFull
    );
  }

  @override
  List<Object> get props => [
        currentScreen,
        showScreenSaver,
        animationDuration,
        inactivityTime,
        images,
        currentIndex,
        currentAnimationType,
        screenSaverFull
      ];
}
