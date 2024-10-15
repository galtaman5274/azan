import 'package:azan/src/features/home/components/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../settings/controllers/prayer_provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.landscape ? const PrayerTimeScreenLandscape() :const PrayerTimeScreenPortrait();
        },)

    );
  }
}
