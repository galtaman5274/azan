import 'package:azan/app/services/audio_service.dart';
import 'package:azan/app/services/location_service.dart';
import 'package:azan/app/services/prayer_service.dart';
import 'package:azan/app/settings/storage_controller.dart';
import 'package:azan/domain/location_settings.dart';
import 'package:azan/injection.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:azan/app/timer/time_provider.dart';
import 'package:azan/presentation/pages/main/main_layout.dart';
import 'package:azan/app/screen_saver/main_provider.dart';
import 'package:azan/app/prayer/prayer_provider.dart';
import 'package:azan/app/settings/settings_provider.dart';
import 'package:azan/presentation/pages/settings/presetup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key});
  static _AppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_AppState>();
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Locale _locale = const Locale('en');
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        // ChangeNotifierProvider(create: (_) => TimeDateNotifier()),
        ChangeNotifierProvider(create: (_) => PrayerTimesNotifier(sl<PrayerService>(),sl<StorageController>())),
        ChangeNotifierProvider(
      create: (_) => SetupProvider())

      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true, // Optional: Enable text adaptation
        builder: (_, child) => MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: _locale, // Current locale (set by the user or system)
          title: 'Azan',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const AppStart(),
            '/setup': (context) => const SetupPage(),
            '/prayer-times': (context) => const ScreenSaver(),
          },
        ),
      ),
    );
  }
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<SetupProvider>(context).storage.checkIfSetupRequired(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
                child: Text('An error occurred. Please try again later.')),
          );
        } else if (snapshot.data == true) {
          return const SetupPage(); // Show Setup Page if settings are missing
        } else {
          return const ScreenSaver(); // Show Main Page if settings are found
        }
      },
    );
  }

  
}
