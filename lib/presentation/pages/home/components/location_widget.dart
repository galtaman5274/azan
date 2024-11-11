import 'package:azan/app/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
return Consumer<SetupProvider>(
      builder: (context, setup, child) {
        return Text('${setup.locationService.locationSettings.city} / ${setup.locationService.locationSettings.country}', style: TextStyle(fontSize: 16));
      },
    );  }
}
