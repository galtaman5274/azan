import 'package:azan/app/quran/events.dart';
import 'package:azan/app/quran/states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../infrastucture/quran/repo.dart';

class QariBloc extends Bloc<QariEvent, QariState> {
  final QariFileHandler fileHandler;

  QariBloc({required this.fileHandler}) : super(QariInitial()) {
    on<LoadQariList>(_onLoadQariList);
    on<SaveQariList>(_onSaveQariList);
  }

  Future<void> _onLoadQariList(LoadQariList event, Emitter<QariState> emit) async {
    emit(QariLoading());
    try {
      final qariList = await fileHandler.readFromFile(event.filePath);
      emit(QariLoaded(qariList));
    } catch (e) {
      emit(QariError('Failed to load Qari list: ${e.toString()}'));
    }
  }

  Future<void> _onSaveQariList(SaveQariList event, Emitter<QariState> emit) async {
    try {
      await fileHandler.writeToFile(event.filePath, event.qariList);
      emit(QariLoaded(event.qariList));
    } catch (e) {
      emit(QariError('Failed to save Qari list: ${e.toString()}'));
    }
  }
}