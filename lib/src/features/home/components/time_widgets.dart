import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../settings/controllers/prayer_provider.dart';

class CurrentTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final time = Provider.of<PrayerTimesNotifier>(context).currentTime;
    return Text(
      time,
      style: const TextStyle(
          color: Colors.brown, fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}

// Widget to Display Time Left for Next Prayer
class TimeLeftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeLeft =
        Provider.of<PrayerTimesNotifier>(context).timeLeftForNextPrayer;
    return Text(
      timeLeft,
      style: const TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}