part of 'bloc.dart';

// Events the Bloc can respond to.
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

// ------------------------
// NAVIGATION EVENTS
// ------------------------
class NavigateToEvent extends NavigationEvent {
  final String screen;
  const NavigateToEvent(this.screen);

  @override
  List<Object?> get props => [screen];
}
class InitializeAnimationEvent extends NavigationEvent {
  final TickerProvider tickerProvider;
  const InitializeAnimationEvent(this.tickerProvider);

  @override
  List<Object?> get props => [tickerProvider];
}
class ToggleScreenSaverEvent extends NavigationEvent {
  final bool show;
  const ToggleScreenSaverEvent(this.show);

  @override
  List<Object?> get props => [show];
}

// ------------------------
// SCREENSAVER SETTINGS
// ------------------------
class LoadSettingsEvent extends NavigationEvent {}
class CheckForLocalFilesEvent extends NavigationEvent {
   final Locale locale;
  const CheckForLocalFilesEvent(this.locale);
}
class ScreenSaverFullEvent extends NavigationEvent {
  final bool screenSaverFull;
  const ScreenSaverFullEvent(this.screenSaverFull);
}

class SaveSettingsEvent extends NavigationEvent {}

class SetAnimationDurationEvent extends NavigationEvent {
  final int duration;
  const SetAnimationDurationEvent(this.duration);

  @override
  List<Object?> get props => [duration];
}

class SetInactivityTimeEvent extends NavigationEvent {
  final int time;
  const SetInactivityTimeEvent(this.time);

  @override
  List<Object?> get props => [time];
}

// ------------------------
// SCREENSAVER LOGIC
// ------------------------
class UpdateImagesEvent extends NavigationEvent {
  final List<String> newImages;
  const UpdateImagesEvent(this.newImages);

  @override
  List<Object?> get props => [newImages];
}

class ResetInactivityTimerEvent extends NavigationEvent {}

// This event is dispatched internally by the BLoC once
// the inactivity timer expires.
class InactivityTimeoutEvent extends NavigationEvent {}

class NextImageEvent extends NavigationEvent {}

/// Example: Could be triggered when an animation completes
/// if you want the BLoC to handle chaining animations/timers.
class AnimationCompletedEvent extends NavigationEvent {}
