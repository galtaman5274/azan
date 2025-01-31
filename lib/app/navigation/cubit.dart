import 'package:hydrated_bloc/hydrated_bloc.dart';

class NavigationCubit extends Cubit<String> {
  String currentPage = 'home';
  NavigationCubit() : super('home');
  void setPage(String name) => emit(name);
}
