// import 'dart:io';
// import 'package:adhan/adhan.dart';
// import 'package:azan/app/prayer/prayer_notifier.dart';
// import 'package:azan/presentation/localization/localization.dart';
// import 'package:azan/presentation/pages/adhan/adhan_page.dart';
// import 'package:azan/presentation/pages/home/home_page.dart';
// import 'package:azan/presentation/pages/settings/settings_screen.dart';
// import 'package:azan/quran/quran_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../app/screen_saver/controller.dart';
// import '../../../app/screen_saver/main_provider.dart';
// import '../../../app/url_provider/url_provider.dart';
// import '../home/components/prayer_time_widgets.dart';
// part 'constants.dart';

// class ScreenSaver extends StatefulWidget {
//   const ScreenSaver({super.key});

//   @override
//   State<ScreenSaver> createState() => _ScreenSaverState();
// }

// class _ScreenSaverState extends State<ScreenSaver>
//     with TickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();

//   }

//   @override
//   Widget build(BuildContext context) {
//     final navigationProvider = Provider.of<NavigationProvider>(context);
//     final contentProvider = Provider.of<ContentProvider>(context)
//         .screenSaver
//         ?.getLocalImages(context.l10n.localeName);
    
//     navigationProvider.initScreenSaverController(contentProvider ?? [], this);
//     return GestureDetector(
//       onTap: navigationProvider.resetInactivityTimer, // Reset timer on tap
//       onPanUpdate: (_) =>
//           navigationProvider.resetInactivityTimer(), // Reset timer on swipe
//       child: SafeArea(
//         child: Scaffold(
//             body: Stack(
//           children: [
//             _buildMainPage(navigationProvider.currentScreen),
//             navigationProvider.showScreenSaver
//                 ? _buildScreenSaver(navigationProvider.screenSaverController)
//                 : const SizedBox()
//           ],
//         )),
//       ),
//     );
//   }

//   Widget _buildMainPage(String currentScreen) {
//     switch (currentScreen) {
//       case 'settings':
//         return const SettingsPage();
//       case 'adhan':
//         return const AdhanPage();
//       case 'home':
//         return const HomePage();
//       case 'quran':
//         return const QuranPage();
//       default:
//         return const HomePage();
//     }
//   }

//   Widget _buildScreenSaver(ScreenSaverController? controller) {
//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             color: Colors.black,
//             child: AnimatedBuilder(
//               animation: controller!.currentAnimation,
//               builder: (context, child) {
//                 Widget animatedImage = controller.images.isNotEmpty
//                     ? Image.file(File(controller
//                         .images[controller.currentIndex])) // Display image
//                     : const Text('Image not found');

//                 switch (controller.currentAnimationType) {
//                   case 'scale':
//                     animatedImage = Transform.scale(
//                       scale: controller.currentAnimation.value,
//                       child: animatedImage,
//                     );
//                     break;
//                   case 'rotation':
//                     animatedImage = Transform.rotate(
//                       angle: controller.currentAnimation.value,
//                       child: animatedImage,
//                     );
//                     break;
//                   case 'fade':
//                   default:
//                     animatedImage = Opacity(
//                       opacity: controller.currentAnimation.value,
//                       child: animatedImage,
//                     );
//                     break;
//                 }

//                 return animatedImage;
//               },
//             ),
//           ),
//         ),
//         Consumer<PrayerTimesNotifier>(
//           builder: (context, provider, _) {
//             return Container(
//               color: Colors.white,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerFajr,
//                     prayerTime: provider.getPrayerTime(Prayer.fajr),
//                     hasPassed: provider.prayerPassed[0],
//                     screenSaver: true,
//                   ),
//                   PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerTulu,
//                     prayerTime: provider.getPrayerTime(Prayer.sunrise),
//                     hasPassed: provider.prayerPassed[1],
//                     screenSaver: true,
//                   ),
//                   PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerDhuhr,
//                     prayerTime: provider.getPrayerTime(Prayer.dhuhr),
//                     hasPassed: provider.prayerPassed[2],
//                     screenSaver: true,
//                   ),
//                   PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerAsr,
//                     prayerTime: provider.getPrayerTime(Prayer.asr),
//                     hasPassed: provider.prayerPassed[3],
//                     screenSaver: true,
//                   ),
//                   PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerMaghrib,
//                     prayerTime: provider.getPrayerTime(Prayer.maghrib),
//                     hasPassed: provider.prayerPassed[4],
//                     screenSaver: true,
//                   ),
//                   PrayerTimeItemWidget(
//                     prayerName: context.l10n.prayerIsha,
//                     prayerTime: provider.getPrayerTime(Prayer.isha),
//                     hasPassed: provider.prayerPassed[5],
//                     screenSaver: true,
//                   ),
//                 ],
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
