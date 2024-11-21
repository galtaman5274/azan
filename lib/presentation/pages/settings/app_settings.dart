import 'package:azan/app.dart';
import 'package:azan/app/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/screen_saver/main_provider.dart';
import '../../localization/localization.dart';
import '../main/main_layout.dart';

class AppSettingsTab extends StatefulWidget {
  const AppSettingsTab({super.key});

  @override
  _AppSettingsTabState createState() => _AppSettingsTabState();
}

class _AppSettingsTabState extends State<AppSettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'System Language:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),
            DropdownButton<Locale>(
              value: context.watch<SetupProvider>().locale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                        Provider.of<SetupProvider>(context, listen: false).setLocale(newLocale);

                }
                  WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NavigationProvider>(context, listen: false).updateImages(Images.getImages(newLocale ??const Locale('en')));
    });

              },
              items: AppLocalizations.supportedLocales.map((locale) {
                return DropdownMenuItem(
                  value: locale,
                  child: Text(locale.languageCode.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        );
  }
    
  
}
