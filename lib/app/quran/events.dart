// Bloc Classes
import '../../domain/qari.dart';

abstract class QariEvent {}

class LoadQariList extends QariEvent {
}

class SaveQariList extends QariEvent {
  final List<Qari> qariList;
  SaveQariList(this.qariList);
}
