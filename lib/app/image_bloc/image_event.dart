part of 'image_bloc.dart';

abstract class ImageEvent {}

class PickImageEvent extends ImageEvent {}

class PickFolderEvent extends ImageEvent {}  // New event for selecting a folder

class LoadImagesEvent extends ImageEvent {}

class DeleteImageEvent extends ImageEvent {
  final File image;
  DeleteImageEvent(this.image);
}
