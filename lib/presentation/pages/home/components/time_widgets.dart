import 'package:azan/presentation/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/prayer/prayer_notifier.dart';

class CurrentTimeWidget extends StatelessWidget {
  const CurrentTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<PrayerTimesNotifier>(context).currentTime;
    return Text(
      time,
      style: const TextStyle(
          color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
    );
  }
}

// Widget to Display Time Left for Next Prayer
class TimeLeftWidget extends StatelessWidget {
  const TimeLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLeft =
        Provider.of<PrayerTimesNotifier>(context).timeLeftForNextPrayer;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.timeLeftText,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        const SizedBox(width: 10,),
        Text(
          timeLeft,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    );
  }
}

class CurrentDateWidget extends StatelessWidget {
  const CurrentDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final date = Provider.of<PrayerTimesNotifier>(context).currentDate;
    return Text(
      date,
      style: const TextStyle( fontSize: 20),
    );
  }
}
