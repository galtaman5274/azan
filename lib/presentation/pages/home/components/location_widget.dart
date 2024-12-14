import 'package:azan/app/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/location_provider/location_provider.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, setup, child) {
        return Text(
            '${setup.locationSettings.city} / ${setup.locationSettings.country}',
            style:const TextStyle(fontSize: 10));
      },
    );
  }
}
