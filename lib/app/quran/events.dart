// Bloc Classes
import '../../domain/qari.dart';

abstract class QariEvent {}

class LoadQariList extends QariEvent {
  final String filePath;
  LoadQariList(this.filePath);
}

class SaveQariList extends QariEvent {
  final String filePath;
  final List<Qari> qariList;
  SaveQariList(this.filePath, this.qariList);
}
