import 'package:audioplayers/audioplayers.dart';
import 'package:azan/app/prayer/prayer_provider.dart';
import 'package:azan/app/services/audio_service.dart';
import 'package:azan/app/services/prayer_service.dart';
import 'package:azan/app/settings/storage_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'app/settings/settings_provider.dart';

final GetIt sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => StorageController(sl<FlutterSecureStorage>()));
  sl.registerLazySingleton<SetupProvider>(() => SetupProvider(sl<StorageController>()));
  sl.registerLazySingleton(() => AudioPlayer());
  sl.registerLazySingleton(() => AdhanAudioService(sl<AudioPlayer>()));
  sl.registerLazySingleton(() => PrayerService(sl<AdhanAudioService>()));
  sl.registerLazySingleton(
      () => PrayerTimesNotifier(sl<PrayerService>(), sl<StorageController>()));
}
