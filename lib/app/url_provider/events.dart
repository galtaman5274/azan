// Bloc Classes
abstract class ContentEvent {}

class CheckForLocal extends ContentEvent {
  final String locale;
  CheckForLocal(this.locale);
}
class LoadContentList extends ContentEvent {
  final String locale;
  LoadContentList(this.locale);
}

class SavedToStorage extends ContentEvent {
  final String locale;
  SavedToStorage(this.locale);
}
