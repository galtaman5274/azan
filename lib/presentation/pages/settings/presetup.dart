import 'dart:async';
import 'package:adhan/adhan.dart';
import 'package:azan/app/settings/settings_provider.dart';
import 'package:country_state_city/country_state_city.dart' as countries_state;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

// Setup Page for Initial Configuration
class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  String? _selectedCountry = 'US'; // Default to 'US' (United States)
  String? _selectedState;
  String? _selectedCity;

  String _latitude = '';
  String _longitude = '';
  int _asrMethodIndex = 0;

  List<countries_state.Country> _countries = [];
  List<countries_state.State> _states = [];
  List<countries_state.City> _cities = [];

  final List<CalculationMethod> _calculationMethods = CalculationMethod.values;

  final List<String> _asrCalculationMethods = ['Asri-Sani', 'Asri-Evvel'];

  CalculationMethod _selectedCalculationMethod = CalculationMethod.values[0];

  @override
  void initState() {
    super.initState();
    _loadCountries(); // Load the list of countries on init
  }

  Future<void> _loadCountries() async {
    final countries = await countries_state.getAllCountries();
    if (mounted) {
      setState(() {
        _countries = countries;
      });
    }
    _loadStates('US'); // Automatically load states for the default country
  }

  Future<void> _loadStates(String countryCode) async {
    final List<countries_state.State> states =
        await countries_state.getStatesOfCountry(countryCode);
    if (mounted) {
      setState(() {
        _states = states;
        _selectedState = null; // Reset selected state when country changes
        _selectedCity = null; // Reset selected city when country changes
        _cities = []; // Reset cities
      });
    }
  }

  Future<void> _loadCities(String countryCode, String stateCode) async {
    final List<countries_state.City> cities =
        await countries_state.getStateCities(countryCode, stateCode);
    if (mounted) {
      setState(() {
        _cities = cities;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Prayer Times'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Dropdown
            const Text('Select Country:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select Country"),
              value: _selectedCountry,
              items: _countries
                  .map((country) => DropdownMenuItem(
                        value: country.isoCode,
                        child: Text(country.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  _states = [];
                  _cities = [];
                });
                _loadStates(value!);
              },
            ),
            const SizedBox(height: 20),

            // State Dropdown
            const Text('Select State:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select State"),
              value: _selectedState,
              items: _states
                  .map((state) => DropdownMenuItem(
                        value: state.isoCode,
                        child: Text(state.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value;
                  _cities = [];
                });
                _loadCities(_selectedCountry!, value!);
              },
            ),
            const SizedBox(height: 20),

            // City Dropdown
            const Text('Select City:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select City"),
              value: _selectedCity,
              items: _cities
                  .map((city) => DropdownMenuItem(
                        value: city.name,
                        child: Text(city.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCity = value;
                });
                _getCoordinates(_selectedCity!);
              },
            ),
            const SizedBox(height: 20),

            // Calculation Method Dropdown
            const Text('Select Calculation Method:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<CalculationMethod>(
              isExpanded: true,
              hint: const Text("Select Calculation Method"),
              value: _selectedCalculationMethod,
              items: _calculationMethods
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCalculationMethod = value as CalculationMethod;
                });
              },
            ),
            const SizedBox(height: 20),

            // Asr Calculation Method Dropdown
            const Text('Select Asr Method:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text("Select Asr Calculation Method"),
              value: _asrCalculationMethods[_asrMethodIndex],
              items: _asrCalculationMethods
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _asrMethodIndex = _asrCalculationMethods.indexOf(value!);
                });
              },
            ),
            const SizedBox(height: 20),

            Text('Latitude: $_latitude, Longitude: $_longitude'),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<SetupProvider>(context,listen: false).saveSettings(
                      latitude: _latitude,
                      longitude: _longitude,
                      selectedCalculationMethod: _selectedCalculationMethod,
                      asrMethodIndex: _asrMethodIndex,country: _selectedCountry as String,city: _selectedCity as String);
                            Navigator.pushReplacementNamed(context, '/prayer-times');

                },
                child: const Text('Save and Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Get coordinates from the selected city using geocoding
  Future<void> _getCoordinates(String city) async {
    try {
      if (_selectedCountry != null &&
          _selectedState != null &&
          city.isNotEmpty) {
        String address = '$city, $_selectedState, $_selectedCountry';
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty && mounted) {
          setState(() {
            _latitude = locations.first.latitude.toString();
            _longitude = locations.first.longitude.toString();
          });
        }
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
    }
  }
}
