import '../../domain/qari.dart';

abstract class QariState {}

class QariInitial extends QariState {}

class QariLoading extends QariState {}

class QariLoaded extends QariState {
  final List<Qari> qariList;
  QariLoaded(this.qariList);
}

class QariError extends QariState {
  final String message;
  QariError(this.message);
}