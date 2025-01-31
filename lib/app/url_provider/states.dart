part of 'bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object?> get props => [];
}

// The initial state when nothing is loaded yet.
class ContentInitial extends ContentState {}

// State when data is being fetched (network call) or images are being saved.
class ContentLoading extends ContentState {}

// State after content is fetched from the server and parsed into models.
class ContentDownloaded extends ContentState {
  final Alert? alerts;
  final AzanFiles? azanFiles;
  final Quran? quranFiles;
  final ScreenSaver? screenSaver;

  const ContentDownloaded({
    this.alerts,
    this.azanFiles,
    this.quranFiles,
    this.screenSaver,
  });

  @override
  List<Object?> get props => [alerts, azanFiles, quranFiles, screenSaver];
}

// State after images are downloaded to local storage.
class ContentSavedToStorage extends ContentState {
  final List<String> savedPaths;

  const ContentSavedToStorage(this.savedPaths);

  @override
  List<Object?> get props => [savedPaths];
}

// State when an error occurs (e.g., network or file system).
class ContentError extends ContentState {
  final String message;

  const ContentError(this.message);

  @override
  List<Object?> get props => [message];
}
