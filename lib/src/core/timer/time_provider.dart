// Shared Time and Date State Notifier
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class TimeDateNotifier extends ChangeNotifier {
  String _currentTime = '';
  String _currentDate = '';

  String get currentTime => _currentTime;
  String get currentDate => _currentDate;

  TimeDateNotifier() {
    _updateTime();
  }

  void _updateTime() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final DateTime now = DateTime.now();
      _currentTime = DateFormat('HH:mm:ss').format(now); // Time format
      _currentDate = DateFormat('MMMM d, yyyy').format(now); // Date format
      notifyListeners(); // Notify all listeners to update
    });
  }
}
