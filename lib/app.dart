import 'package:azan/app/locale_provider/locale_provider.dart';
import 'package:azan/app/quran/events.dart';
import 'package:azan/app/services/audio_service.dart';
import 'package:azan/domain/location_settings.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:azan/injection.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:azan/presentation/pages/main/main_layout.dart';
import 'package:azan/app/screen_saver/main_provider.dart';
import 'package:azan/app/prayer/prayer_notifier.dart';
import 'package:azan/presentation/pages/settings/presetup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/location_provider/location_provider.dart';
import 'app/quran/bloc.dart';
import 'app/services/storage_controller.dart';
import 'infrastucture/quran/repo.dart';

class App extends StatefulWidget {
  const App({super.key});


  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final qariFileHandler = QariFileHandlerImpl();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider(sl<StorageController>())..init()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider(sl<LocationSettings>())..init()),
        ChangeNotifierProvider(create: (_) => PrayerTimesNotifier( sl<PrayerSettings>(), sl<AdhanAudioService>())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true, // Optional: Enable text adaptation
        builder: (_, child) => Consumer<LocaleProvider>(
          builder: ( context, provider, _) {
          return BlocProvider(
            create: (context) => QariBloc(fileHandler: qariFileHandler)..add(LoadQariList()),

            child: MaterialApp(
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: provider.locale, // Current locale (set by the user or system)
              title: 'Azan',
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (context) => const AppStart(),
                '/setup': (context) => const SetupPage(),
                '/prayer-times': (context) => const ScreenSaver(),
              },
            ),
          );}
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
      future:
          Provider.of<LocationProvider>(context).locationSettings.checkIfSetupRequired(),
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
