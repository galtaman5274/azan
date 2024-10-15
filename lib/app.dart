import 'package:azan/src/core/localization/localization.dart';
import 'package:azan/src/core/timer/time_provider.dart';
import 'package:azan/src/features/main/main_layout.dart';
import 'package:azan/src/features/main/main_provider.dart';
import 'package:azan/src/features/settings/controllers/prayer_provider.dart';
import 'package:azan/src/features/settings/view/presetup.dart';
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
        ChangeNotifierProvider(create: (_) => TimeDateNotifier()),
        ChangeNotifierProvider(create: (_) => PrayerTimesNotifier())
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true, // Optional: Enable text adaptation
        builder: (_, child) => MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: _locale, // Current locale (set by the user or system)
          title: 'Elif',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
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
      future: _checkIfSetupRequired(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data == true) {
          return const SetupPage(); // Show Setup Page if settings are missing
        } else {
          return const ScreenSaver(); // Show Main Page if settings are found
        }
      },
    );
  }

  Future<bool> _checkIfSetupRequired() async {
    const storage = FlutterSecureStorage();
    final latitude = await storage.read(key: 'latitude');
    final longitude = await storage.read(key: 'longitude');
    final method = await storage.read(key: 'calculationMethod');
    return latitude == null || longitude == null || method == null;
  }
}
