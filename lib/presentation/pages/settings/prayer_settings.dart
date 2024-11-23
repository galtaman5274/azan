import 'package:azan/app.dart';
import 'package:azan/app/prayer/prayer_notifier.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerSettingsTab extends StatelessWidget {
   PrayerSettingsTab({super.key});

   Map<String, String> prayerAdjustments = {
    'fajr': '0',
    'tulu': '0',
    'dhuhr': '0',
    'asr': '0',
    'magrib': '0',
    'isha': '0'
  };


  @override
  Widget build(BuildContext context) {
    Map<String, String> prayerAdjustmentsLocalization = {
      'fajr': context.l10n.prayerFajr,
      'tulu': context.l10n.prayerTulu,
      'dhuhr': context.l10n.prayerDhuhr,
      'asr': context.l10n.prayerAsr,
      'magrib': context.l10n.prayerMaghrib,
      'isha': context.l10n.prayerIsha
    };
    return Consumer<PrayerTimesNotifier>(
      builder: (context, provider, _) {
         return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adjust Prayer Times (in minutes):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Column(
              children: prayerAdjustments.keys.map((prayer) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      prayerAdjustmentsLocalization[prayer]!.toUpperCase(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: prayerAdjustments[prayer].toString(),
                        ),
                        onChanged: (value) {
                          prayerAdjustments[prayer] = value;

                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(

                onPressed: () {
                  provider.saveAdjustments(prayerAdjustments);
                },

                child: const Text('Save Adjustments'),
              ),
            ),
          ],
        );
      },
    );
  }
}
