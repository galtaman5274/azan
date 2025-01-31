import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'data_models.dart';
part 'states.dart';
part 'events.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final Dio _dio;
  final AudioPlayer _audioPlayer;
  final String url = 'https://app.ayine.tv/Ayine/ayine.json';

  ContentBloc(this._dio, this._audioPlayer) : super(ContentInitial()) {
    on<SavedToStorage>(saveImagesToLocal);
    on<LoadContentList>(_onFetchAndStoreContent);
    on<CheckForLocal>(_checkForLocal);
  }
  Future<void> _checkForLocal(
    CheckForLocal event,
    Emitter<ContentState> emit,
  ) async {
    final List<String> savedPaths = [];
    emit(ContentLoading());
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
      }
      add(LoadContentList(event.locale));
      emit(ContentSavedToStorage(List.from(savedPaths)));
    } catch (e) {
      // Log the error for debugging purposes
      print('Error in _checkForLocal: $e');
      emit(ContentError('Error checking local content: $e'));
    }
  }

  Future<void> _onFetchAndStoreContent(
      LoadContentList event, Emitter<ContentState> emit) async {
    
    emit(ContentLoading());
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      final data = response.data;

      final alerts = Alert.fromJson(data['Alert']);
      final azanFiles = AzanFiles.fromJson(data['AzanFiles']);
      final quranFiles = Quran.fromJson(data['Quran']);
      final screenSaver = ScreenSaver.fromJson(data['ScreenSaver']);

      // Emit ContentDownloaded after successfully fetching and parsing data
      emit(ContentDownloaded(
        alerts: alerts,
        azanFiles: azanFiles,
        quranFiles: quranFiles,
        screenSaver: screenSaver,
      ));

      add(SavedToStorage(event.locale));
    } on DioException catch (dioError) {
      emit(ContentError('Network/Dio error: ${dioError.message}'));
    } catch (error) {
      emit(ContentError('Error fetching data: $error'));
    }
  }

  /// Download images to the local filesystem and emit a ContentSavedToStorage state.
  Future<void> saveImagesToLocal(
      SavedToStorage event, Emitter<ContentState> emit) async {
    // We only allow saving if the content was already downloaded
    final currentState = state;
    if (currentState is ContentDownloaded) {
      final screenSaver = currentState.screenSaver;
      if (screenSaver == null) {
        emit(const ContentError('No screenSaver data found.'));
        return;
      }

      final images = screenSaver.getImages(event.locale);
      final List<String> savedPaths = [];

      emit(ContentLoading());
      try {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final Directory directory =
            Directory('${appDocDir.path}/screen_savers/${event.locale}');
        // if (directory.listSync().length != images.length)
        //   directory.deleteSync();
        // Create the directory if it doesn't exist
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
          for (final imageUrl in images) {
            final uri = Uri.parse(imageUrl);

            final response = await _dio.get(
              imageUrl,
              options: Options(responseType: ResponseType.bytes),
            );

            if (response.statusCode == 200) {
              final fileName = uri.pathSegments.last;
              final file = File('${directory.path}/$fileName');

              // Write binary data to the file
              await file.writeAsBytes(response.data);
              savedPaths.add(file.absolute.path);

              // Optionally save to local in your ScreenSaver model
              screenSaver.saveToLocal(file.absolute.path, event.locale);

              print('File saved: ${file.absolute.path}');
            } else {
              print(
                  'Failed to download $imageUrl. Status code: ${response.statusCode}');
            }
          }
        } else {
          final List<FileSystemEntity> files = directory.listSync();
          for (var file in files) {
            if (file is File) {
              // Ensure it's a file and not a directory
              savedPaths.add(file.path);
            }
          }

          if (savedPaths.length != images.length) {
            directory
                .delete(recursive: true)
                .then((_) => directory.createSync(recursive: true));

            for (final imageUrl in images) {
              final uri = Uri.parse(imageUrl);

              final response = await _dio.get(
                imageUrl,
                options: Options(responseType: ResponseType.bytes),
              );

              if (response.statusCode == 200) {
                final fileName = uri.pathSegments.last;
                final file = File('${directory.path}/$fileName');

                // Write binary data to the file
                await file.writeAsBytes(response.data);
                savedPaths.add(file.absolute.path);

                // Optionally save to local in your ScreenSaver model
                screenSaver.saveToLocal(file.absolute.path, event.locale);

                print('File saved: ${file.absolute.path}');
              } else {
                print(
                    'Failed to download $imageUrl. Status code: ${response.statusCode}');
              }
            }
          }
        }

        // Once images are saved, we emit the ContentSavedToStorage state
        emit(ContentSavedToStorage(savedPaths));
      } catch (e) {
        emit(ContentError('Error downloading images: $e'));
      }
    } else {
      emit(const ContentError('Content must be downloaded first.'));
    }
  }
}
