import 'package:audioplayers/audioplayers.dart';
import 'package:azan/app/image_bloc/image_bloc.dart';
import 'package:azan/app/locale_provider/locale_provider.dart';
import 'package:azan/app/main_layout/bloc.dart';
import 'package:azan/app/navigation/cubit.dart';
import 'package:azan/app/prayer/prayer_notifier.dart';
import 'package:azan/app/services/audio_service.dart';
import 'package:azan/app/services/prayer_service.dart';
import 'package:azan/app/url_provider/bloc.dart';
import 'package:azan/domain/location_settings.dart';
import 'package:azan/domain/prayer_settings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'app/location_provider/location_provider.dart';
import 'app/services/storage_controller.dart';

final GetIt sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  sl.registerLazySingleton<StorageController>(
      () => StorageController(sl<FlutterSecureStorage>()));
  //sl.registerLazySingleton<NavigationProvider>(
  //    () => NavigationProvider(sl<StorageController>()));
  sl.registerLazySingleton<AudioPlayer>(() => AudioPlayer());
  sl.registerLazySingleton<AdhanAudioService>(
      () => AdhanAudioService(sl<AudioPlayer>()));
  sl.registerLazySingleton<PrayerService>(
      () => PrayerService(sl<AdhanAudioService>()));
  sl.registerLazySingleton<PrayerSettings>(() =>
      PrayerSettings(storageController: sl<StorageController>())
        ..initializeFromStorage());
  sl.registerLazySingleton<PrayerTimesNotifier>(
      () => PrayerTimesNotifier(sl<PrayerSettings>(), sl<AdhanAudioService>()));
  sl.registerLazySingleton<LocationSettings>(
      () => LocationSettings(storageController: sl<StorageController>()));
  sl.registerLazySingleton<LocationProvider>(
      () => LocationProvider(sl<LocationSettings>()));
  sl.registerLazySingleton(() => Dio());    
  //sl.registerLazySingleton<ContentProvider>(() => ContentProvider(sl<Dio>()));
  //sl.registerLazySingleton<ContentBloc>(() => ContentBloc(sl<Dio>()));
  sl.registerLazySingleton<MainBloc>(() => MainBloc(storage: sl<StorageController>()));
    sl.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
    sl.registerLazySingleton<LocaleCubit>(() => LocaleCubit(sl<StorageController>()));
sl.registerLazySingleton<ImageBloc>(() => ImageBloc());
sl.registerLazySingleton<ContentBloc>(() => ContentBloc(sl<Dio>(),sl<AudioPlayer>()));
}
