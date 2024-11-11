import 'package:adhan/adhan.dart';


class Values {
  static double rightPositions(bool isPortrait, Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return isPortrait? 0.0:0.0;
      case Prayer.sunrise:
        return isPortrait? 0.0:0.0;
      case Prayer.dhuhr:
        return isPortrait? 0.0:0.0;
      case Prayer.asr:
        return isPortrait? 0.0:0.0;
      case Prayer.maghrib:
        return isPortrait? 0.0:0.0;
      case Prayer.isha:
        return isPortrait? 0.0:0.0;
      default:
        return isPortrait? 0.0:0.0;
    }
  }
  static double bottomPositions(bool isPortrait, Prayer prayer) {
    switch (prayer) {
      case Prayer.fajr:
        return isPortrait? 0.0:0.0;
      case Prayer.sunrise:
        return isPortrait? 0.0:0.0;
      case Prayer.dhuhr:
        return isPortrait? 0.0:0.0;
      case Prayer.asr:
        return isPortrait? 0.0:0.0;
      case Prayer.maghrib:
        return isPortrait? 0.0:0.0;
      case Prayer.isha:
        return isPortrait? 0.0:0.0;
      default:
        return isPortrait? 0.0:0.0;
    }
  }
}
