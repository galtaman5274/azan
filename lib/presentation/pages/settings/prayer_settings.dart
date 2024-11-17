// lib/presentation/settings/prayer_settings_tab.dart
<<<<<<< HEAD
import 'package:azan/app/prayer/prayer_notifier.dart';
=======
import 'package:azan/app/prayer/prayer_provider.dart';
import 'package:azan/app/services/prayer_service.dart';
>>>>>>> 5af6144 (fist)
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class PrayerSettingsTab extends StatefulWidget {
  const PrayerSettingsTab({super.key});

  @override
  _PrayerSettingsTabState createState() => _PrayerSettingsTabState();
}

class _PrayerSettingsTabState extends State<PrayerSettingsTab> {
<<<<<<< HEAD
  Map<String, String> prayerAdjustments = {
    'fajr': '0',
    'tulu': '0',
    'dhuhr': '0',
    'asr': '0',
    'magrib': '0',
    'isha': '0'
  };
=======
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Store adjustment values for prayer times in minutes
>>>>>>> 5af6144 (fist)

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimesNotifier>(
      builder: (context, provider, _) {
<<<<<<< HEAD
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
=======
        Map<String, String> prayerAdjustments = provider.loadAdjustments();
        return Column(
>>>>>>> 5af6144 (fist)
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
                      prayer.toUpperCase(),
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
<<<<<<< HEAD
                          prayerAdjustments[prayer] = value;
=======
                         
                            prayerAdjustments[prayer] = value;
                          
>>>>>>> 5af6144 (fist)
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
<<<<<<< HEAD
                onPressed: () {
                  provider.saveAdjustments(prayerAdjustments);
                },
=======
                onPressed: () => provider.saveAdjustments(prayerAdjustments),
>>>>>>> 5af6144 (fist)
                child: const Text('Save Adjustments'),
              ),
            ),
          ],
        );
      },
    );
  }
}
