import 'package:equatable/equatable.dart';

import '../../model/audio_file_model.dart';
import 'home_state.dart';


abstract class HomeEvents extends Equatable{
  @override
  List<Object> get props=>[];
}
class GetSongEvent extends HomeEvents{}
class GetFavSongEvent extends HomeEvents{}
class ChangeLoadingStatusSong extends HomeEvents{
  final Status songStatus;
  ChangeLoadingStatusSong({required this.songStatus,});
  @override
  List<Object> get props=>[songStatus,];
}
class ChangeLoadingStatusFav extends HomeEvents{
  final Status songStatus;
  ChangeLoadingStatusFav({required this.songStatus,});
  @override
  List<Object> get props=>[songStatus,];
}
class AddToFavouriteEvent extends HomeEvents{
  final AudioFile file;
  AddToFavouriteEvent({required this.file});
  @override
  List<Object> get props=>[file];
}
class AddToAlbum extends HomeEvents{
  final AudioFile file;
  AddToAlbum({required this.file});
  @override
  List<Object> get props=>[file];
}