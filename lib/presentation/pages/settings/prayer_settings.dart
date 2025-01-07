import 'package:azan/app/prayer/prayer_notifier.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrayerSettingsTab extends StatefulWidget {
  PrayerSettingsTab({super.key});

  @override
  State<PrayerSettingsTab> createState() => _PrayerSettingsTabState();
}

class _PrayerSettingsTabState extends State<PrayerSettingsTab> {
  Map<String, int> prayerAdjustments = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePrayerAdjustments();
  }

  Future<void> _initializePrayerAdjustments() async {
    final provider = context.read<PrayerTimesNotifier>();
    final adjustments = <String, int>{};

    for (var prayer in ['fajr', 'tulu', 'dhuhr', 'asr', 'magrib', 'isha']) {
      final value =
          await provider.prayerSettings.storageController.getValue(prayer);
      adjustments[prayer] = int.tryParse(value ?? '0') ?? 0;
    }

    setState(() {
      prayerAdjustments = adjustments;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> prayerAdjustmentsLocalization = {
      'fajr': context.l10n.prayerFajr,
      'tulu': context.l10n.prayerTulu,
      'dhuhr': context.l10n.prayerDhuhr,
      'asr': context.l10n.prayerAsr,
      'magrib': context.l10n.prayerMaghrib,
      'isha': context.l10n.prayerIsha,
    };

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                      width: 180,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                prayerAdjustments[prayer] =
                                    (prayerAdjustments[prayer]! - 1);
                              });
                            },
                            child: const Text('-'),
                          ),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: prayerAdjustments[prayer].toString(),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                prayerAdjustments[prayer] =
                                    (prayerAdjustments[prayer]! + 1);
                              });
                            },
                            child: const Text('+'),
                          ),
                        ],
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
                  final updatedAdjustments = prayerAdjustments.map(
                    (key, value) => MapEntry(key, value.toString()),
                  );
                  provider.saveAdjustments(updatedAdjustments);
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

// class PrayerSettingsTab extends StatefulWidget {
//   PrayerSettingsTab({super.key});

//   @override
//   State<PrayerSettingsTab> createState() => _PrayerSettingsTabState();
// }

// class _PrayerSettingsTabState extends State<PrayerSettingsTab> {
//   Map<String, String> prayerAdjustments = {
//     'fajr': '0',
//     'tulu': '0',
//     'dhuhr': '0',
//     'asr': '0',
//     'magrib': '0',
//     'isha': '0'
//   };


//   @override
//   Widget build(BuildContext context) {

//     Map<String, String> prayerAdjustmentsLocalization = {
//       'fajr': context.l10n.prayerFajr,
//       'tulu': context.l10n.prayerTulu,
//       'dhuhr': context.l10n.prayerDhuhr,
//       'asr': context.l10n.prayerAsr,
//       'magrib': context.l10n.prayerMaghrib,
//       'isha': context.l10n.prayerIsha
//     };
    
//     return Consumer<PrayerTimesNotifier>(
//       builder: (context, provider, _) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Adjust Prayer Times (in minutes):',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               children: prayerAdjustments.keys.map((prayer) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       prayerAdjustmentsLocalization[prayer]!.toUpperCase(),
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                     FutureBuilder(
//                       future: provider.prayerSettings.storageController
//                           .getValue(prayer),
//                       builder: (context, snapshot) {
//                           // cureentValue =
//                           //   int.parse(prayerAdjustments[prayer]!);
//                         // if (snapshot.hasData) {
//                         //   cureentValue= int.parse(snapshot.data!)                         ;
//                         // }
//                         prayerAdjustments[prayer]=snapshot.data!;
//                       int  cureentValue=int.tryParse(prayerAdjustments[prayer]!)??0;
//                         return SizedBox(
//                           width: 180,
//                           child: Row(
//                             children: [
//                               ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       //  cureentValue =
//                                       //     int.parse(prayerAdjustments[prayer]!);
//                                       cureentValue--;
//                                       prayerAdjustments[prayer] =
//                                           cureentValue.toString();
//                                            print(
//                                           'cureent value -----> ${cureentValue}');
//                                     });
//                                   },
//                                   child: const Text('-')),
//                               Expanded(
//                                 child: TextField(
//                                   readOnly: true,
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(
//                                     hintText: cureentValue.toString(),
//                                   ),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       // cureentValue =
//                                       //     int.parse(prayerAdjustments[prayer]!);
//                                       cureentValue++;
//                                       prayerAdjustments[prayer] =
//                                           cureentValue.toString();
//                                           print('cureent value ++---> ${cureentValue}');
//                                     });
//                                   },
//                                   child: const Text('+')),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 30),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   provider.saveAdjustments(prayerAdjustments);
//                 },
//                 child: const Text('Save Adjustments'),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
