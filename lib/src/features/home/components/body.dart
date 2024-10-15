import 'package:adhan/adhan.dart';
import 'package:azan/src/features/home/components/main_button.dart';
import 'package:azan/src/features/home/components/prayer_time_widgets.dart';
import 'package:azan/src/features/home/components/time_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../settings/controllers/prayer_provider.dart';

class PrayerTimeScreenPortrait extends StatelessWidget {
  const PrayerTimeScreenPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimesNotifier>(
        builder: (context, notifier, _) {
          return notifier.prayerTimes == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(children: [
                  Image.asset(
                    'assets/images/home_1.png',
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Image.asset(
                    'assets/images/back_frame_date_508.png',
                    fit: BoxFit.fill,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                    right: 0,
                    top: 80,
                    child: Image.asset(
                      'assets/images/clock_frame_v6.png',
                      fit: BoxFit.contain,
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Text('Location: ${notifier.city}, ${notifier.country}'),
                  Positioned(right: 33, top: 130, child: CurrentTimeWidget()),
                  Positioned(right: 45, top: 180, child: TimeLeftWidget()),
                  Positioned(
                    right: 42,
                    bottom: 250,
                    child: PrayerTimeItemWidget(
                      prayerName: 'Fajr',
                      prayerTime: notifier.getPrayerTime(Prayer.fajr),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 150,
                    child: PrayerTimeItemWidget(
                      prayerName: 'Tulu',
                      prayerTime: notifier.getPrayerTime(Prayer.sunrise),
                    ),
                  ),
                  Positioned(
                    right: 90,
                    bottom: 150,
                    child: PrayerTimeItemWidget(
                      prayerName: 'Dhuhr',
                      prayerTime: notifier.getPrayerTime(Prayer.dhuhr),
                    ),
                  ),
                  Positioned(
                    right: 22,
                    bottom: 40,
                    child: PrayerTimeItemWidget(
                      prayerName: 'Asr',
                      prayerTime: notifier.getPrayerTime(Prayer.asr),
                    ),
                  ),
                  Positioned(
                    right: 90,
                    bottom: 40,
                    child: PrayerTimeItemWidget(
                      prayerName: 'Maghrib',
                      prayerTime: notifier.getPrayerTime(Prayer.maghrib),
                    ),
                  ),
                  Positioned(
                    right: 162,
                    bottom: 40,
                    child: PrayerTimeItemWidget(
                      prayerName: 'Isha',
                      prayerTime: notifier.getPrayerTime(Prayer.isha),
                    ),
                  ),
            const Positioned(
                left: 0,
                bottom: 0,
                child: MainButton(
                  img: 'bg_close',
                  text: 'close',
                  turnOff: true,
                )),
            const Positioned(
                left: 0,
                bottom: 150,
                child: MainButton(img: 'azan_frame', text: 'adhan')),
            const Positioned(
                left: 20,
                bottom: 90,
                child: MainButton(img: 'bg_quran', text: 'quran')),
            const Positioned(
                left: 40,
                bottom: 40,
                child: MainButton(img: 'bg_settings', text: 'settings')),
                ]);
        },
      )
    ;
  }
}

class PrayerTimeScreenLandscape extends StatelessWidget {
  const PrayerTimeScreenLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimesNotifier>(
      builder: (context, notifier, _) {
        return notifier.prayerTimes == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
          Image.asset(
            'assets/images/home_1.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/back_frame_date_508.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            right: 70,
            top: 0,
            child: Image.asset(
              'assets/images/clock_frame_v6.png',
              fit: BoxFit.contain,
              height: 170,
              width: 170,
            ),
          ),
          Text('Location: ${notifier.city}, ${notifier.country}'),
          Positioned(right: 109, top: 48, child: CurrentTimeWidget()),
          Positioned(right: 125, top: 105, child: TimeLeftWidget()),
          Positioned(
            right: 100,
            bottom: 130,
            child: PrayerTimeItemWidget(
              prayerName: 'Fajr',
              prayerTime: notifier.getPrayerTime(Prayer.fajr),
            ),
          ),
          Positioned(
            right: 130,
            bottom: 70,
            child: PrayerTimeItemWidget(
              prayerName: 'Tulu',
              prayerTime: notifier.getPrayerTime(Prayer.sunrise),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 70,
            child: PrayerTimeItemWidget(
              prayerName: 'Dhuhr',
              prayerTime: notifier.getPrayerTime(Prayer.dhuhr),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 0,
            child: PrayerTimeItemWidget(
              prayerName: 'Asr',
              prayerTime: notifier.getPrayerTime(Prayer.asr),
            ),
          ),
          Positioned(
            right: 130,
            bottom: 0,
            child: PrayerTimeItemWidget(
              prayerName: 'Maghrib',
              prayerTime: notifier.getPrayerTime(Prayer.maghrib),
            ),
          ),
          Positioned(
            right: 200,
            bottom: 0,
            child: PrayerTimeItemWidget(
              prayerName: 'Isha',
              prayerTime: notifier.getPrayerTime(Prayer.isha),
            ),
          ),
          const Positioned(
              left: 0,
              bottom: 0,
              child: MainButton(
                img: 'bg_close',
                text: 'close',
                turnOff: true,
              )),
          const Positioned(
              left: 0,
              bottom: 150,
              child: MainButton(img: 'azan_frame', text: 'adhan')),
          const Positioned(
              left: 20,
              bottom: 90,
              child: MainButton(img: 'bg_quran', text: 'quran')),
          const Positioned(
              left: 40,
              bottom: 40,
              child: MainButton(img: 'bg_settings', text: 'settings')),
        ]);
      },
    )
    ;
  }
}
// Widget to Display Current Time

