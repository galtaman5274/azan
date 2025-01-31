import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import '../services/storage_controller.dart';
part 'states.dart';
part 'events.dart';

class MainBloc extends Bloc<NavigationEvent, NavigationState> {
  final StorageController storage;
  MainBloc({required this.storage}) : super(NavigationState.initial()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<SaveSettingsEvent>(_onSaveSettings);
    on<CheckForLocalFilesEvent>(_onCheckForLocalFiles);
    on<NavigateToEvent>(_onNavigateTo);
    on<ToggleScreenSaverEvent>(_onToggleScreenSaver);

    on<SetAnimationDurationEvent>(_onSetAnimationDuration);
    on<SetInactivityTimeEvent>(_onSetInactivityTimeEvent);

    on<UpdateImagesEvent>(_onUpdateImages);
    on<ResetInactivityTimerEvent>(_onResetInactivityTimer);
    on<InactivityTimeoutEvent>(_onInactivityTimeout);

    on<NextImageEvent>(_onNextImage);
    on<AnimationCompletedEvent>(_onAnimationCompleted);
    on<ScreenSaverFullEvent>(_onScreenSaverFull);
    // Optionally, automatically load settings on creation:
    add(LoadSettingsEvent());

    _startInactivityTimer();
    _startImageChangeTimer();
  }

  Timer? _inactivityTimer;
  Timer? _imageChangeTimer;
  final Random _random = Random();

  Future<void> _onScreenSaverFull(
      ScreenSaverFullEvent event, Emitter<NavigationState> emit) async {
    print(event.screenSaverFull);
    emit(state.copyWith(screenSaverFull: event.screenSaverFull));
  }
  Future<void> _onLoadSettings(
      LoadSettingsEvent event, Emitter<NavigationState> emit) async {
    final storedAnimationDuration = await storage.getValue('animationDuration');
    final storedInactivityTimer = await storage.getValue('inactivityTimer');

    final newAnimationDuration =
        int.tryParse(storedAnimationDuration ?? '') ?? state.animationDuration;
    final newInactivityTime =
        int.tryParse(storedInactivityTimer ?? '') ?? state.inactivityTime;

    emit(state.copyWith(
      animationDuration: newAnimationDuration,
      inactivityTime: newInactivityTime,
    ));
  }

  Future<void> _onSaveSettings(
      SaveSettingsEvent event, Emitter<NavigationState> emit) async {
    await storage.saveValue(
        'animationDuration', state.animationDuration.toString());
    await storage.saveValue('inactivityTimer', state.inactivityTime.toString());
    // No change to state here, but you could emit a "Saved" status if needed.
  }

  void _onNavigateTo(NavigateToEvent event, Emitter<NavigationState> emit) {
    emit(
      state.copyWith(
        currentScreen: event.screen,
        showScreenSaver: false,
      ),
    );
  }

  void _onCheckForLocalFiles(
      CheckForLocalFilesEvent event, Emitter<NavigationState> emit) async {
    final List<String> savedPaths = [];
    //emit(ContentLoading());

    try {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final Directory directory =
          Directory('${appDocDir.path}/screen_savers/${event.locale}');

      // Check if the directory exists and contains files
      if (!directory.existsSync() || directory.listSync().isEmpty) {
        print('Objects are not present');
      } else {
        print('Objects are present');

        // Extract all file paths and add to savedPaths
        final List<FileSystemEntity> files = directory.listSync();
        for (var file in files) {
          if (file is File) {
            // Ensure it's a file and not a directory
            savedPaths.add(file.path);
          }
        }
        add(UpdateImagesEvent(savedPaths));
      }
    } catch (e) {
      // Log the error for debugging purposes
      print('Error in _checkForLocal: $e');
      //emit(ContentError('Error checking local content: $e'));
    }
  }

  void _onToggleScreenSaver(
      ToggleScreenSaverEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(showScreenSaver: event.show));
  }

  void _onSetAnimationDuration(
      SetAnimationDurationEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(animationDuration: event.duration));
    _restartImageChangeTimer(); // if you want the new duration to take effect immediately
  }

  void _onSetInactivityTimeEvent(
      SetInactivityTimeEvent event, Emitter<NavigationState> emit) {
    emit(state.copyWith(inactivityTime: event.time));
    _restartInactivityTimer();
  }

  void _onUpdateImages(UpdateImagesEvent event, Emitter<NavigationState> emit) {
    if (event.newImages.isEmpty) {
      emit(state.copyWith(
        images: const [
          Image(
            image: AssetImage('assets/screen_savers/tr/1-allah.jpg'),
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Image(
            image: AssetImage('assets/screen_savers/tr/2-rahman.jpg'),
            fit: BoxFit.fill,
            width: double.infinity,
          )
        ],
        currentIndex: 0,
      ));
    } else {
      final List<Widget> newImages = event.newImages
          .map<Widget>((item) => Image.file(
                File(item),
                fit: BoxFit.fill,
                width: double.infinity,
              ))
          .toList();
      emit(state.copyWith(images: newImages, currentIndex: 0));
    }
  }

  void _onResetInactivityTimer(
      ResetInactivityTimerEvent event, Emitter<NavigationState> emit) {
    // If the screensaver was showing, hide it upon interaction:
    if (state.showScreenSaver) {
      emit(state.copyWith(showScreenSaver: false));
    }
    _restartInactivityTimer();
  }

  void _onInactivityTimeout(
      InactivityTimeoutEvent event, Emitter<NavigationState> emit) {
    // If inactivity times out, show the screensaver:
    if (!state.showScreenSaver) {
      emit(state.copyWith(showScreenSaver: true));
    }
  }

  void _onNextImage(NextImageEvent event, Emitter<NavigationState> emit) {
    if (state.images.isEmpty) return;
    final newIndex = (state.currentIndex + 1) % state.images.length;
    emit(
      state.copyWith(
        currentIndex: newIndex,
        currentAnimationType: _getRandomAnimationType(),
      ),
    );
  }

  void _onAnimationCompleted(
      AnimationCompletedEvent event, Emitter<NavigationState> emit) {
    // Typically you might do something once the animation is done,
    // for example scheduling the next image or randomizing again.
  }

  // ---------------
  // TIMERS
  // ---------------

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(
      Duration(seconds: state.inactivityTime),
      () => add(InactivityTimeoutEvent()),
    );
  }

  void _restartInactivityTimer() {
    _inactivityTimer?.cancel();
    _startInactivityTimer();
  }

  /// This timer periodically triggers a new image if the screen saver is active.
  void _startImageChangeTimer() {
    _imageChangeTimer?.cancel();
    // We'll run this every (animationDuration + some offset) seconds
    // so that the UI can perform the transition in between.
    _imageChangeTimer = Timer.periodic(
      Duration(seconds: state.animationDuration + 2),
      (timer) {
        // Only change images if the screen saver is shown
        if (state.showScreenSaver) {
          add(NextImageEvent());
        }
      },
    );
  }

  void _restartImageChangeTimer() {
    _imageChangeTimer?.cancel();
    _startImageChangeTimer();
  }

  // ---------------
  // HELPERS
  // ---------------
  String _getRandomAnimationType() {
    final animations = ['fade', 'scale', 'rotate'];
    return animations[_random.nextInt(animations.length)];
  }

  // ---------------
  // OVERRIDE CLOSE
  // ---------------
  @override
  Future<void> close() {
    _inactivityTimer?.cancel();
    _imageChangeTimer?.cancel();
    return super.close();
  }
}
