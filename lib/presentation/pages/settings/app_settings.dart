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
    final navigator = context.watch<NavigationProvider>();
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
                  //navigator.updateImages(Images.getImages(newLocale));
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
          const Text(
            'Animation Duration (seconds)',
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Slider(
            value: navigator.animationDuration?.toDouble() ?? 0,
            min: 1,
            max: 60,
            divisions: 60,
            label: navigator.animationDuration.toString(),
            onChanged: (value) =>
                navigator.setAnimationDuration(value.toInt()) 
             
            ,
          ),
          const SizedBox(height: 20),
          const Text(
            'Inactivity Time (seconds)',
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Slider(
            value: navigator.inactivityTimer?.toDouble() ?? 1,
            min: 1,
            max: 60,
            divisions: 60,
            label: navigator.inactivityTimer.toString(),
            onChanged: (value) =>
              
                navigator.setInactivityTimer(value.toInt())
            
            ,
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

