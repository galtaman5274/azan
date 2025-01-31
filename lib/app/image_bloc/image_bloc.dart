import 'dart:io';
//import 'package:file_picker/file_picker.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
part 'image_event.dart';
part 'image_state.dart';
class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  ImageBloc() : super(ImageInitialState()) {
    on<PickImageEvent>(_pickImage);
    on<LoadImagesEvent>(_loadImages);
    on<DeleteImageEvent>(_deleteImage);
    // on<PickFolderEvent>(_pickFolder);  // Handle folder selection
  }

//  Future<void> _pickFolder(PickFolderEvent event, Emitter<ImageState> emit) async {
//   if (Platform.isAndroid || Platform.isMacOS || Platform.isWindows) {
//     // File Picker supports directory selection on Android, MacOS, and Windows
//     String? folderPath = await FilePicker.platform.getDirectoryPath();
//     if (folderPath != null) {
//       _loadImagesFromFolder(folderPath, emit);
//     } else {
//       emit(ImageLoadedState(_images)); // No folder selected
//     }
//   } else if (Platform.isIOS) {
//     // iOS does NOT support selecting folders, so we load from a fixed directory
//     final directory = await getApplicationDocumentsDirectory();
//     final folderPath = directory.path;
//     _loadImagesFromFolder(folderPath, emit);
//   }
// }

  /// Load images from the selected folder
  Future<void> _loadImagesFromFolder(
      String folderPath, Emitter<ImageState> emit) async {
    final folder = Directory(folderPath);
    if (folder.existsSync()) {
      final images = folder
          .listSync()
          .where((file) => file.path.endsWith('.jpg') || file.path.endsWith('.png'))
          .map((file) => File(file.path))
          .toList();
      _images = images;
      emit(ImageLoadedState(_images));
    } else {
      emit(ImageLoadedState([]));
    }
  }
  Future<void> _pickImage(
      PickImageEvent event, Emitter<ImageState> emit) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final directory = await getApplicationDocumentsDirectory();
        final folderPath = "${directory.path}/MyImages";
        final folder = Directory(folderPath);
        if (!folder.existsSync()) {
          folder.createSync();
        }
        final fileName = pickedFile.name;
        final savedImage =
            await File(pickedFile.path).copy("$folderPath/$fileName");
        _images.add(savedImage);
        emit(ImageLoadedState(_images));
      }
    } else {
      emit(ImageLoadedState(_images));
    }
  }

  Future<void> _loadImages(
      LoadImagesEvent event, Emitter<ImageState> emit) async {
    final directory = await getApplicationDocumentsDirectory();
    final folderPath = "${directory.path}/MyImages";
    final folder = Directory(folderPath);
    if (folder.existsSync()) {
      final images = folder.listSync().map((file) => File(file.path)).toList();
      _images = images;
      emit(ImageLoadedState(_images));
    } else {
      emit(ImageLoadedState([]));
    }
  }

  Future<void> _deleteImage(
      DeleteImageEvent event, Emitter<ImageState> emit) async {
    final image = event.image;
    if (image.existsSync()) {
      image.deleteSync();
      _images.remove(image);
      emit(ImageLoadedState(_images));
    }
  }
}
