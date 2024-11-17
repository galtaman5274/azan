import 'package:azan/presentation/pages/settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app/screen_saver/main_provider.dart';
import 'prayer_settings.dart'; // Import the new tab

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _currentSection = 'Prayer Adjustments';

  @override
  Widget build(BuildContext context) {
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
                  _buildMenuItem(Icons.access_time, 'Prayer Adjustments'),
                  _buildMenuItem(Icons.settings, 'Tab 2'),
                  _buildMenuItem(Icons.info, 'Tab 3'),
                ],
              ),
            ),
            // Content Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Use Provider to navigate back to home
          Provider.of<NavigationProvider>(context, listen: false)
              .navigateTo('home');
        },
        child: const Icon(Icons.home),
        tooltip: 'Go to Home',
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String section) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: IconButton(
        icon: Icon(icon),
        color: _currentSection == section ? Colors.blue : Colors.white,
        iconSize: 30.0,
        onPressed: () {
          setState(() {
            _currentSection = section;
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_currentSection) {
      case 'Prayer Adjustments':
        return const PrayerSettingsTab(); // Use the new widget
      case 'App Settings':
        return const AppSettingsTab();

      case 'Tab 3':
        return const Center(child: Text('Tab 3 Content Here'));
      default:
        return const Center(child: Text('Content not found'));
    }
  }
}
