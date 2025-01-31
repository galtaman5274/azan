import 'package:audioplayers/audioplayers.dart';
import 'package:azan/app/image_bloc/image_bloc.dart';
import 'package:azan/app/locale_provider/locale_provider.dart';
import 'package:azan/app/main_layout/bloc.dart';
import 'package:azan/app/navigation/cubit.dart';
import 'package:azan/app/services/audio_service.dart';
import 'package:azan/domain/location_settings.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:azan/injection.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:azan/presentation/pages/main/main_layout.dart';
import 'package:azan/app/prayer/prayer_notifier.dart';
import 'package:azan/presentation/pages/settings/presetup/presetup.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/location_provider/location_provider.dart';
import 'app/services/storage_controller.dart';
import 'app/url_provider/bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ChangeNotifierProvider(
        //     create: (_) => NavigationProvider(sl<StorageController>())),

        ChangeNotifierProvider(
            create: (_) => LocationProvider(sl<LocationSettings>())..init()),
        ChangeNotifierProvider(
            create: (_) => PrayerTimesNotifier(
                sl<PrayerSettings>(), sl<AdhanAudioService>())),
        // ChangeNotifierProvider(
        //     create: (_) => ContentProvider(sl<Dio>())
        //       ..fetchAndStoreContent(conte
        //
        //
        // xt.l10n.localeName)),
        BlocProvider(create: (_) => ContentBloc(sl<Dio>(),sl<AudioPlayer>())),
        BlocProvider(create: (_) => MainBloc(storage: sl<StorageController>())),
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(
            create: (_) => LocaleCubit(sl<StorageController>())..initLocale()),
        BlocProvider(create: (_) => ImageBloc())
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true, // Optional: Enable text adaptation
          builder: (_, child) => const MainApp()),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: context
          .watch<LocaleCubit>()
          .state, // Current locale (set by the user or system)
      title: 'Azan',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const AppStart(),
        '/setup': (context) => const SetupPage(),
        '/prayer-times': (context) => const ScreenSaver(),
      },
    );
  }
}

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<LocationProvider>(context)
          .locationSettings
          .checkIfSetupRequired(),
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
          final locale = context.watch<LocaleCubit>().state.languageCode;
          context.read<ContentBloc>().add(CheckForLocal(locale));
          return const ScreenSaver(); // Show Main Page if settings are found
        }
      },
    );
  }
}
