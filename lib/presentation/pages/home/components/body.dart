import 'package:adhan/adhan.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:azan/presentation/pages/home/components/location_widget.dart';
import 'package:azan/presentation/pages/home/components/main_button.dart';
import 'package:azan/presentation/pages/home/components/prayer_time_widgets.dart';
import 'package:azan/presentation/pages/home/components/time_widgets.dart';
import 'package:azan/presentation/pages/home/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../app/prayer/prayer_notifier.dart';

class PrayerTimeScreenLandscape extends StatelessWidget {
  const PrayerTimeScreenLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimesNotifier>(
      builder: (context, notifier, _) {
        return notifier.prayerTimes
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                Image.asset(
                  notifier.currentBackgroundImage,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Image.asset(
                  Assets.backFrame,
                  fit: BoxFit.fill,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Positioned(
                  right: -54.w,
                  top: 60,
                  child: Image.asset(
                    Assets.clockFrame,
                    fit: BoxFit.contain,
                    height: 250.h,
                    width: 250.w,
                  ),
                ),
                const Positioned(right: 0, bottom: 0, child: LocationWidget()),
                Positioned(
                    right: 58.w, top: 140.h, child: const CurrentTimeWidget()),
                Positioned(
                    right: 63.w, top: 220.h, child: const TimeLeftWidget()),
                Positioned(
                    right: 227.dg,
                    bottom: 10.dg,
                    child: const CurrentDateWidget()),
                Positioned(
                  right: 50.w,
                  bottom: 250.h,
                  child: PrayerTimeItemWidget(
                    prayerName: context.l10n.prayerFajr,
                    prayerTime: notifier.getPrayerTime(Prayer.fajr),
                    hasPassed: notifier.prayerSevice.prayerPassed[0],
                  ),
                ),
                Positioned(
                  right: 80.w,
                  bottom: 140.h,
                  child: PrayerTimeItemWidget(
                    prayerName: context.l10n.prayerTulu,
                    prayerTime: notifier.getPrayerTime(Prayer.sunrise),
                    hasPassed: notifier.prayerSevice.prayerPassed[1],
                  ),
                ),
                Positioned(
                  right: 20.w,
                  bottom: 140.h,
                  child: PrayerTimeItemWidget(
                    prayerName: context.l10n.prayerDhuhr,
                    prayerTime: notifier.getPrayerTime(Prayer.dhuhr),
                    hasPassed: notifier.prayerSevice.prayerPassed[2],
                  ),
                ),
                Positioned(
                  right: 20.w,
                  bottom: 10,
                  child: PrayerTimeItemWidget(
                    prayerName: context.l10n.prayerAsr,
                    prayerTime: notifier.getPrayerTime(Prayer.asr),
                    hasPassed: notifier.prayerSevice.prayerPassed[3],
                  ),
                ),
                Positioned(
                  right: 80.w,
                  bottom: 10,
                  child: PrayerTimeItemWidget(
                    prayerName: context.l10n.prayerMaghrib,
                    prayerTime: notifier.getPrayerTime(Prayer.maghrib),
                    hasPassed: notifier.prayerSevice.prayerPassed[4],
                  ),
                ),
                Positioned(
                  right: 140.w,
                  bottom: 10,
                  child: PrayerTimeItemWidget(
                    prayerName: context.l10n.prayerIsha,
                    prayerTime: notifier.getPrayerTime(Prayer.isha),
                    hasPassed: notifier.prayerSevice.prayerPassed[5],
                  ),
                ),
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: MainButton(
                      img: 'bg_close',
                      text: context.l10n.homeButtonClose,
                      turnOff: true,
                    )),
                Positioned(
                    left: 0,
                    bottom: 150.h,
                    child: MainButton(
                        img: 'azan_frame', text: context.l10n.homeButtonAdhan)),
                Positioned(
                    left: 20.w,
                    bottom: 75.h,
                    child: MainButton(
                        img: 'bg_quran', text: context.l10n.homeButtonQuran)),
                Positioned(
                    left: 50.w,
                    bottom: 25.h,
                    child: MainButton(
                        img: 'bg_settings',
                        text: context.l10n.homeButtonSettings)),
              ]);
      },
    );
  }
}





// class PrayerTimeScreenPortrait extends StatelessWidget {
//   const PrayerTimeScreenPortrait({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PrayerTimesNotifier>(
//       builder: (context, notifier, _) {
//         return notifier.prayerTimes == null
//             ? const Center(child: CircularProgressIndicator())
//             : Stack(children: [
//                 Image.asset(
//                   Assets.homeScreen,
//                   fit: BoxFit.fill,
//                   height: double.infinity,
//                   width: double.infinity,
//                 ),
//                 Image.asset(
//                   Assets.backFrame,
//                   fit: BoxFit.fill,
//                   height: double.infinity,
//                   width: double.infinity,
//                 ),
//                 Positioned(
//                   right: 0,
//                   top: 80.h,
//                   child: Image.asset(
//                     Assets.clockFrame,
//                     fit: BoxFit.contain,
//                     height: 150.h,
//                     width: 150.w,
//                   ),
//                 ),
//                 Text('Location: ${notifier.city}, ${notifier.country}'),
//                 Positioned(right: 33, top: 130, child: CurrentTimeWidget()),
//                 Positioned(right: 45, top: 180, child: TimeLeftWidget()),
//                 Positioned(
//                   right: 42.w,
//                   bottom: 250.h,
//                   child: PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerFajr,
//                     prayerTime: notifier.getPrayerTime(Prayer.fajr),
//                   ),
//                 ),
//                 Positioned(
//                   right: 20.w,
//                   bottom: 150.h,
//                   child: PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerTulu,
//                     prayerTime: notifier.getPrayerTime(Prayer.sunrise),
//                   ),
//                 ),
//                 Positioned(
//                   right: 90.w,
//                   bottom: 150.h,
//                   child: PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerDhuhr,
//                     prayerTime: notifier.getPrayerTime(Prayer.dhuhr),
//                   ),
//                 ),
//                 Positioned(
//                   right: 22.w,
//                   bottom: 40.h,
//                   child: PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerAsr,
//                     prayerTime: notifier.getPrayerTime(Prayer.asr),
//                   ),
//                 ),
//                 Positioned(
//                   right: 90.w,
//                   bottom: 40.h,
//                   child: PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerMaghrib,
//                     prayerTime: notifier.getPrayerTime(Prayer.maghrib),
//                   ),
//                 ),
//                 Positioned(
//                   right: 162.w,
//                   bottom: 40.h,
//                   child: PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerIsha,
//                     prayerTime: notifier.getPrayerTime(Prayer.isha),
//                   ),
//                 ),
//                 Positioned(
//                     left: 0,
//                     bottom: 0,
//                     child: MainButton(
//                       img: 'bg_close',
//                       text: context.l10n.homeButtonClose,
//                       turnOff: true,
//                     )),
//                 Positioned(
//                     left: 0,
//                     bottom: 150.h,
//                     child: MainButton(
//                         img: 'azan_frame', text: context.l10n.homeButtonAdhan)),
//                 Positioned(
//                     left: 20.w,
//                     bottom: 90.h,
//                     child: MainButton(
//                         img: 'bg_quran', text: context.l10n.homeButtonQuran)),
//                 Positioned(
//                     left: 40.w,
//                     bottom: 40.h,
//                     child: MainButton(
//                         img: 'bg_settings',
//                         text: context.l10n.homeButtonSettings)),
//               ]);
//       },
//     );
//   }
// }
