import 'package:azan/presentation/pages/settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/screen_saver/main_provider.dart';
import '../../../app/settings/settings_provider.dart';
import 'prayer_settings.dart'; // Import the new tab

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
final List<Widget> menuItems = [
  const MenuItem(  icon:Icons.access_time, section: 'Prayer Adjustments',index: 0,),
  const MenuItem(  icon:Icons.settings, section: 'App Settings',index: 1,),

  const MenuItem(  icon:Icons.info, section: 'tap',index: 2,),
];
final List<Widget> menuContent = [ PrayerSettingsTab(),const AppSettingsTab(),const Center(child: Text('tap'),)];
  @override
  Widget build(BuildContext context) {
    final index = context.watch<SetupProvider>().currentIndex;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            // Left-side menu
            Container(
              width: 70,
              color: Colors.grey[900],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ...menuItems
                ],
              ),
            ),
            // Content Area
            Expanded(
              child:  IndexedStack(
                index: index,
                children: menuContent,
              ),

            ),
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
      child: IconButton(
        icon: Icon(icon),
        color: context.read<SetupProvider>().currentIndex == index ? Colors.blue : Colors.white,
        iconSize: 30.0,
        onPressed: () =>context.read<SetupProvider>().setCurrentIndex(index),
      ),
    );
  }
}
