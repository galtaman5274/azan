import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:developer';

import 'injection.dart';

void main() async {
  
  runZonedGuarded(
    () async {
      // Ensure bindings are initialized
      WidgetsFlutterBinding.ensureInitialized();
      // Initialize dependencies and configurations
      await ScreenUtil.ensureScreenSize();
      // Initialize Hydrated Storage
      // final storage = await HydratedStorage.build(
      //   storageDirectory:
      //       await getApplicationDocumentsDirectory(), // Mobile/desktop storage
      // );

      //HydratedBloc.storage = storage; // Set the global storage for HydratedBloc
      setup();
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
