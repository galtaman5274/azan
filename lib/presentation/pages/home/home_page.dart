import 'package:azan/presentation/pages/home/components/body.dart';
import 'package:flutter/material.dart';


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
          return  const PrayerTimeScreenLandscape();
        },)

    );
  }
}
