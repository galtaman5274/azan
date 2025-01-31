// part of 'bloc.dart';

// class NavigationState extends Equatable {
//   final String currentScreen;
//   final bool showScreenSaver;
//   final int animationDuration;   // The time to show each image or run an animation
//   final int inactivityTime;      // Time before screensaver kicks in
//   final List<String> images;
//   final int currentIndex;
//   final String currentAnimationType; // e.g., fade, scale, rotation

//   const NavigationState({
//     required this.currentScreen,
//     required this.showScreenSaver,
//     required this.animationDuration,
//     required this.inactivityTime,
//     required this.images,
//     required this.currentIndex,
//     required this.currentAnimationType,
//   });

//   // Initial State
//   factory NavigationState.initial() {
//     return NavigationState(
//       currentScreen: 'home',
//       showScreenSaver: false,
//       animationDuration: 30,
//       inactivityTime: 15,
//       images: const [],
//       currentIndex: 0,
//       currentAnimationType: 'fade',
//     );
//   }

//   NavigationState copyWith({
//     String? currentScreen,
//     bool? showScreenSaver,
//     int? animationDuration,
//     int? inactivityTime,
//     List<String>? images,
//     int? currentIndex,
//     String? currentAnimationType,
//   }) {
//     return NavigationState(
//       currentScreen: currentScreen ?? this.currentScreen,
//       showScreenSaver: showScreenSaver ?? this.showScreenSaver,
//       animationDuration: animationDuration ?? this.animationDuration,
//       inactivityTime: inactivityTime ?? this.inactivityTime,
//       images: images ?? this.images,
//       currentIndex: currentIndex ?? this.currentIndex,
//       currentAnimationType: currentAnimationType ?? this.currentAnimationType,
//     );
//   }

//   @override
//   List<Object> get props => [
//         currentScreen,
//         showScreenSaver,
//         animationDuration,
//         inactivityTime,
//         images,
//         currentIndex,
//         currentAnimationType,
//       ];
// }
