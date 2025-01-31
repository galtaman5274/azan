import 'package:flutter/material.dart';

// class LocaleProvider extends ChangeNotifier {
//   Locale _locale = const Locale('en');

//   Locale get locale => _locale;

//   void setLocale(Locale locale) {
//     _locale = locale;
//     notifyListeners();
//   }
// }

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../services/storage_controller.dart';

class LocaleCubit extends Cubit<Locale> {
  final StorageController _storage;
  LocaleCubit(this._storage) : super(const Locale('tr'));
  Future<String> initLocale() async {
    final locale = await _storage.getValue('locale');
    if (locale != null) {
      setLocale(Locale(locale));
      return locale;
    } else {
      return 'tr';
    }
  }

  void setLocale(Locale name) {
    _storage.saveValue('locale', name.languageCode);
    emit(name);
  }
}
