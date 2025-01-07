import 'package:azan/app/locale_provider/locale_provider.dart';
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
  final Map<String, String> lang = {
    'en': 'English',
    'de': 'Deutsch',
    'ar': 'العربية',
    'tr': 'Türkçe',
  };


  @override
  Widget build(BuildContext context) {
    final navigator = context.read<NavigationProvider>();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.systemLanguage,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          DropdownButton<Locale>(
            value: context.watch<LocaleProvider>().locale,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                context.read<LocaleProvider>().setLocale(newLocale);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  navigator.updateImages(Images.getImages(newLocale));
                });
              }
            },
            items: AppLocalizations.supportedLocales.map((locale) {
              return DropdownMenuItem(
                value: locale,
                child: Text(lang[locale.toString()] as String),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Text(
            'Animation Duration (seconds)',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Slider(
            value: navigator.animationDuration.toDouble(),
            min: 5,
            max: 60,
            divisions: 11,
            label: navigator.animationDuration.toString(),
            onChanged: (value) {
              setState(() {
                navigator.animationDuration =value.toInt();
              });
            },
          ),
          const SizedBox(height: 20),
          Text(
            'Inactivity Time (seconds)',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Slider(
            value: navigator.incativityTimer.toDouble(),
            min: 10,
            max: 300,
            divisions: 29,
            label: navigator.incativityTimer.toString(),
            onChanged: (value) {
              setState(() {
                navigator.incativityTimer = value.toInt();
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: navigator.saveSaverSettings,
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }
}

