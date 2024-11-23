import 'package:azan/app.dart';
import 'package:azan/presentation/localization/localization.dart';
import 'package:azan/presentation/pages/settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/screen_saver/main_provider.dart';
import '../../../app/settings/settings_provider.dart';
import 'location_settings.dart';
import 'prayer_settings.dart'; // Import the new tab

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.l10n.settings),
      ),
      body: const SingleChildScrollView(
        child: Row(
          children: [
            // Left-side menu
             LeftMenu(),
            Content(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<NavigationProvider>().navigateTo('home'),
        tooltip: 'Go to Home',
        child: const Icon(Icons.home),
      ),
    );
  }

}
class MenuItem extends StatelessWidget {
  const MenuItem({super.key,required this.icon, required this.section,required this.index});
final IconData icon;
final String section;
final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(icon),
            color: context.read<SetupProvider>().currentIndex == index ? Colors.blue : Colors.white,
            iconSize: 30.0,
            onPressed: () =>context.read<SetupProvider>().setCurrentIndex(index),
          ),
          TextButton(onPressed: () =>context.read<SetupProvider>().setCurrentIndex(index), child: Text(section,style:const TextStyle(color: Colors.white),)),

        ],
      ),
    );
  }
}
class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    final index = context.watch<SetupProvider>().currentIndex;

    return Expanded(
      child:  Padding(
        padding: const EdgeInsets.all(30.0),
        child: IndexedStack(
          index: index,
          children: [ PrayerSettingsTab(),const AppSettingsTab(),const Center(child: Text('tap'),),const SetupLocation()],
        ),
      ),
    );
  }
}

class LeftMenu extends StatelessWidget {
  const LeftMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      color: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          MenuItem(  icon:Icons.access_time, section: context.l10n.prayerSettings,index: 0,),
           MenuItem(  icon:Icons.settings, section: context.l10n.appSettings,index: 1,),
           MenuItem(  icon:Icons.book, section: context.l10n.quranSettings,index: 2,),
           MenuItem(  icon:Icons.location_on_outlined, section: context.l10n.locationSettings,index: 3,),
        ],
      ),
    );
  }
}
