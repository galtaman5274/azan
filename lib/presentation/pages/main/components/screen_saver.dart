import 'package:flutter/material.dart';
import 'image_animation.dart';
import 'screen_saver_prayer_times.dart';

class MainScreenSaver extends StatefulWidget {
  const MainScreenSaver(
      {super.key,});

  @override
  State<MainScreenSaver> createState() => _MainScreenSaverState();
}

class _MainScreenSaverState extends State<MainScreenSaver> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child:const ImageAnimation(),
            ),
          ),
          const ScreenSaverPrayerTimes(),
        ],
      );
    
  }
}
