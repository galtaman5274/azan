import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../../app/screen_saver/main_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _storage = const FlutterSecureStorage();

  // Store adjustment values for prayer times in minutes
  Map<String, int> _prayerAdjustments = {
    'fajr': 0,
    'dhuhr': 0,
    'asr': 0,
    'maghrib': 0,
    'isha': 0,
  };

  String _currentSection = 'Prayer Adjustments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Row(
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
        return _buildPrayerAdjustmentsTab();
      case 'Tab 2':
        return const Center(child: Text('Tab 2 Content Here'));
      case 'Tab 3':
        return const Center(child: Text('Tab 3 Content Here'));
      default:
        return const Center(child: Text('Content not found'));
    }
  }

  Widget _buildPrayerAdjustmentsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Adjust Prayer Times (in minutes):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 20),
        Column(
          children: _prayerAdjustments.keys.map((prayer) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prayer.toUpperCase(),
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: _prayerAdjustments[prayer].toString(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _prayerAdjustments[prayer] = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        Center(
          child: ElevatedButton(
            onPressed: _saveAdjustments,
            child: const Text('Save Adjustments'),
          ),
        ),
      ],
    );
  }

  Future<void> _saveAdjustments() async {
    for (var prayer in _prayerAdjustments.keys) {
      await _storage.write(
          key: 'adjustment_$prayer',
          value: _prayerAdjustments[prayer].toString());
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Prayer time adjustments saved successfully!')),
    );
  }
}
