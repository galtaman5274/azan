import 'package:azan/presentation/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/prayer/prayer_notifier.dart';

class CurrentTimeWidget extends StatelessWidget {
  const CurrentTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<PrayerTimesNotifier>(context).prayerSevice.currentTime;
    return Text(
      time,
      style: const TextStyle(
          color: Colors.brown, fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}

// Widget to Display Time Left for Next Prayer
class TimeLeftWidget extends StatelessWidget {
  const TimeLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLeft =
        Provider.of<PrayerTimesNotifier>(context).prayerSevice.timeLeftForNextPrayer;
    return Column(
      children: [
        Text(
          context.l10n.timeLeftText,
          style: const TextStyle(fontSize: 8, color: Colors.brown),
        ),
        Text(
          timeLeft,
          style: const TextStyle(fontSize: 15, color: Colors.brown),
        ),
      ],
    );
  }
}

class CurrentDateWidget extends StatelessWidget {
  const CurrentDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<PrayerTimesNotifier>(context).prayerSevice.currentDate;
    return Text(
      date,
      style: const TextStyle(
          color: Colors.orange, fontSize: 10),
    );
  }
}