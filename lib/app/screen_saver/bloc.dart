// import 'dart:async';
// import 'dart:math';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../services/storage_controller.dart';
// part 'states.dart';
// part 'events.dart';

// class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
//   final StorageController storage;
//   NavigationBloc({required this.storage}) : super(NavigationState.initial()) {
//     on<LoadSettingsEvent>(_onLoadSettings);
//     on<SaveSettingsEvent>(_onSaveSettings);

//     on<NavigateToEvent>(_onNavigateTo);
//     on<ToggleScreenSaverEvent>(_onToggleScreenSaver);

//     on<SetAnimationDurationEvent>(_onSetAnimationDuration);
//     on<SetInactivityTimeEvent>(_onSetInactivityTimeEvent);

//     on<UpdateImagesEvent>(_onUpdateImages);
//     on<ResetInactivityTimerEvent>(_onResetInactivityTimer);
//     on<InactivityTimeoutEvent>(_onInactivityTimeout);

//     on<NextImageEvent>(_onNextImage);
//     on<AnimationCompletedEvent>(_onAnimationCompleted);

//     // Optionally, automatically load settings on creation:
//     add(LoadSettingsEvent());

//     _startInactivityTimer();
//     _startImageChangeTimer();
//   }

//   Timer? _inactivityTimer;
//   Timer? _imageChangeTimer;
//   final Random _random = Random();

//   // ---------------
//   // EVENT HANDLERS
//   // ---------------

//   Future<void> _onLoadSettings(
//       LoadSettingsEvent event, Emitter<NavigationState> emit) async {
//     final storedAnimationDuration = await storage.getValue('animationDuration');
//     final storedInactivityTimer = await storage.getValue('inactivityTimer');

//     final newAnimationDuration =
//         int.tryParse(storedAnimationDuration ?? '') ?? state.animationDuration;
//     final newInactivityTime =
//         int.tryParse(storedInactivityTimer ?? '') ?? state.inactivityTime;

//     emit(state.copyWith(
//       animationDuration: newAnimationDuration,
//       inactivityTime: newInactivityTime,
//     ));
//   }

//   Future<void> _onSaveSettings(
//       SaveSettingsEvent event, Emitter<NavigationState> emit) async {
//     await storage.saveValue(
//         'animationDuration', state.animationDuration.toString());
//     await storage.saveValue('inactivityTimer', state.inactivityTime.toString());
//     // No change to state here, but you could emit a "Saved" status if needed.
//   }

//   void _onNavigateTo(NavigateToEvent event, Emitter<NavigationState> emit) {
//     emit(
//       state.copyWith(
//         currentScreen: event.screen,
//         showScreenSaver: false,
//       ),
//     );
//   }

//   void _onToggleScreenSaver(
//       ToggleScreenSaverEvent event, Emitter<NavigationState> emit) {
//     emit(state.copyWith(showScreenSaver: event.show));
//   }

//   void _onSetAnimationDuration(
//       SetAnimationDurationEvent event, Emitter<NavigationState> emit) {
//     emit(state.copyWith(animationDuration: event.duration));
//     _restartImageChangeTimer(); // if you want the new duration to take effect immediately
//   }

//   void _onSetInactivityTimeEvent(
//       SetInactivityTimeEvent event, Emitter<NavigationState> emit) {
//     emit(state.copyWith(inactivityTime: event.time));
//     _restartInactivityTimer();
//   }

//   void _onUpdateImages(UpdateImagesEvent event, Emitter<NavigationState> emit) {
//     emit(state.copyWith(images: event.newImages, currentIndex: 0));
//   }

//   void _onResetInactivityTimer(
//       ResetInactivityTimerEvent event, Emitter<NavigationState> emit) {
//     // If the screensaver was showing, hide it upon interaction:
//     if (state.showScreenSaver) {
//       emit(state.copyWith(showScreenSaver: false));
//     }
//     _restartInactivityTimer();
//   }

//   void _onInactivityTimeout(
//       InactivityTimeoutEvent event, Emitter<NavigationState> emit) {
//     // If inactivity times out, show the screensaver:
//     if (!state.showScreenSaver) {
//       emit(state.copyWith(showScreenSaver: true));
//     }
//   }

//   void _onNextImage(NextImageEvent event, Emitter<NavigationState> emit) {
//     if (state.images.isEmpty) return;
//     final newIndex = (state.currentIndex + 1) % state.images.length;
//     emit(
//       state.copyWith(
//         currentIndex: newIndex,
//         currentAnimationType: _getRandomAnimationType(),
//       ),
//     );
//   }

//   void _onAnimationCompleted(
//       AnimationCompletedEvent event, Emitter<NavigationState> emit) {
//     // Typically you might do something once the animation is done,
//     // for example scheduling the next image or randomizing again.
//   }

//   // ---------------
//   // TIMERS
//   // ---------------

//   void _startInactivityTimer() {
//     _inactivityTimer?.cancel();
//     _inactivityTimer = Timer(
//       Duration(seconds: state.inactivityTime),
//       () => add(InactivityTimeoutEvent()),
//     );
//   }

//   void _restartInactivityTimer() {
//     _inactivityTimer?.cancel();
//     _startInactivityTimer();
//   }

//   /// This timer periodically triggers a new image if the screen saver is active.
//   void _startImageChangeTimer() {
//     _imageChangeTimer?.cancel();
//     // We'll run this every (animationDuration + some offset) seconds
//     // so that the UI can perform the transition in between.
//     _imageChangeTimer = Timer.periodic(
//       Duration(seconds: state.animationDuration + 2),
//       (timer) {
//         // Only change images if the screen saver is shown
//         if (state.showScreenSaver) {
//           add(NextImageEvent());
//         }
//       },
//     );
//   }

//   void _restartImageChangeTimer() {
//     _imageChangeTimer?.cancel();
//     _startImageChangeTimer();
//   }

//   // ---------------
//   // HELPERS
//   // ---------------
//   String _getRandomAnimationType() {
//     final animations = ['fade', 'scale', 'rotation'];
//     return animations[_random.nextInt(animations.length)];
//   }

//   // ---------------
//   // OVERRIDE CLOSE
//   // ---------------
//   @override
//   Future<void> close() {
//     _inactivityTimer?.cancel();
//     _imageChangeTimer?.cancel();
//     return super.close();
//   }
// }
