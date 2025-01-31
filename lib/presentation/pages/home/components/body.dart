import 'package:adhan/adhan.dart';
import 'package:azan/app/main_layout/bloc.dart';
import 'package:azan/app/navigation/cubit.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:azan/presentation/pages/home/components/location_widget.dart';
import 'package:azan/presentation/pages/home/components/main_button.dart';
import 'package:azan/presentation/pages/home/components/prayer_time_widgets.dart';
import 'package:azan/presentation/pages/home/components/time_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../app/prayer/prayer_notifier.dart';

class PrayerTimeScreenLandscape extends StatelessWidget {
  const PrayerTimeScreenLandscape({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTimesNotifier>(
      builder: (context, notifier, _) {
        return
            // notifier.prayerSettings.prayerTimes == null
            //     ? const Center(child: CircularProgressIndicator())
            //     :
            Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/mecca.jpg',
              ), // Replace with your image path
              fit: BoxFit.fill,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                iconSize: 30,
                color: Colors.white,
                onPressed: () => SystemNavigator.pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            Center(
              child: Container(
                width: 1000,
                height: 600,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(80, 211, 207, 207),
                  borderRadius: BorderRadius.circular(20),
                ), // Rounded corners
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MainButton(
                          text: context.l10n.homeButtonQuran,
                          nav: 'quran',
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        MainButton(
                          text: context.l10n.homeButtonAdhan,
                          nav: 'adhan',
                        ),
                        IconButton(
                            color: Colors.white,
                            onPressed: () {
                              //context.read<MainBloc>().add(const NavigateToEvent('settings'));
                              context
                                  .read<NavigationCubit>()
                                  .setPage('settings');
                              context
                                  .read<MainBloc>()
                                  .add(ResetInactivityTimerEvent());
                              // final provider = Provider.of<NavigationProvider>(
                              //     context,
                              //     listen: false);
                              // provider.navigateTo('settings');
                              // provider.resetInactivityTimer();
                            },
                            icon: const Icon(Icons.settings))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/Sultanahmet.jpg'),
                          height: 400,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 2, 60, 107),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              width: 300,
                              child: const Column(
                                children: [
                                  CurrentTimeWidget(),
                                  TimeLeftWidget()
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                PrayerTimeItemWidget(
                                  prayerName: context.l10n.prayerFajr,
                                  prayerTime:
                                      notifier.getPrayerTime(Prayer.fajr),
                                  hasPassed: notifier.prayerPassed[0],
                                  screenSaver: false,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                PrayerTimeItemWidget(
                                  prayerName: context.l10n.prayerTulu,
                                  prayerTime:
                                      notifier.getPrayerTime(Prayer.sunrise),
                                  hasPassed: notifier.prayerPassed[1],
                                  screenSaver: false,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                PrayerTimeItemWidget(
                                  prayerName: context.l10n.prayerDhuhr,
                                  prayerTime:
                                      notifier.getPrayerTime(Prayer.dhuhr),
                                  hasPassed: notifier.prayerPassed[2],
                                  screenSaver: false,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                PrayerTimeItemWidget(
                                  prayerName: context.l10n.prayerAsr,
                                  prayerTime:
                                      notifier.getPrayerTime(Prayer.asr),
                                  hasPassed: notifier.prayerPassed[3],
                                  screenSaver: false,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                PrayerTimeItemWidget(
                                  prayerName: context.l10n.prayerMaghrib,
                                  prayerTime:
                                      notifier.getPrayerTime(Prayer.maghrib),
                                  hasPassed: notifier.prayerPassed[4],
                                  screenSaver: false,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                PrayerTimeItemWidget(
                                  prayerName: context.l10n.prayerIsha,
                                  prayerTime:
                                      notifier.getPrayerTime(Prayer.isha),
                                  hasPassed: notifier.prayerPassed[5],
                                  screenSaver: false,
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 500,
                      color: Colors.amber,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocationWidget(),
                          SizedBox(
                            width: 20,
                          ),
                          CurrentDateWidget(),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ]),
        );
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
