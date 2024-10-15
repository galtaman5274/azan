import 'app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:developer';

Future<void> bootstrap() async {
  runZonedGuarded(
    () async {
      // Ensure bindings are initialized
      WidgetsFlutterBinding.ensureInitialized();
      // Initialize dependencies and configurations
      await ScreenUtil.ensureScreenSize();
      // Initialize Hydrated Storage
      final storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorage.webStorageDirectory // Web-specific storage
            : await getApplicationDocumentsDirectory(), // Mobile/desktop storage
      );

      HydratedBloc.storage = storage; // Set the global storage for HydratedBloc
      runApp(const App());
    },
    (error, stackTrace) {
      log(
        error.toString(),
        stackTrace: stackTrace,
      );
    },
  );
}
