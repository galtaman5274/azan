import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import '../../../app/screen_saver/main_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  final _storage = const FlutterSecureStorage();
  TabController? _tabController;

  // Store adjustment values for prayer times in minutes
  Map<String, int> _prayerAdjustments = {
    'fajr': 0,
    'dhuhr': 0,
    'asr': 0,
    'maghrib': 0,
    'isha': 0,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Prayer Adjustments'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Prayer Adjustments Tab
          _buildPrayerAdjustmentsTab(),

          // Empty Tabs for Future Use
          const Center(child: Text('Tab 2 Content Here')),
          const Center(child: Text('Tab 3 Content Here')),
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

  Widget _buildPrayerAdjustmentsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
      ),
    );
  }

  Future<void> _saveAdjustments() async {
    for (var prayer in _prayerAdjustments.keys) {
      await _storage.write(
          key: 'adjustment_$prayer',
          value: _prayerAdjustments[prayer].toString());
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Prayer time adjustments saved successfully!')),
    );
  }
}
