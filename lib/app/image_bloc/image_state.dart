part of 'image_bloc.dart';

abstract class ImageState {}

class ImageInitialState extends ImageState {}

class ImageLoadedState extends ImageState {
  final List<File> images;
  ImageLoadedState(this.images);
}

