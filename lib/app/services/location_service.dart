// services/location_service.dart
import 'package:country_state_city/country_state_city.dart' as countries_state;
import 'package:geocoding/geocoding.dart';

import '../../domain/location_settings.dart';

class LocationService {
  final LocationSettings locationSettings;
  LocationService(this.locationSettings);
  Future<List<countries_state.Country>> loadCountries() async {
    return await countries_state.getAllCountries();
  }

  Future<List<countries_state.State>> loadStates(String countryCode) async {
    return await countries_state.getStatesOfCountry(countryCode);
  }

  Future<List<countries_state.City>> loadCities(String countryCode, String stateCode) async {
    return await countries_state.getStateCities(countryCode, stateCode);
  }

  Future<(double, double)> getCoordinates(String country, String state, String city) async {
    double latitude = 0;
    double longitude = 0;
    try {
      String address = '$city, $state, $country';
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        latitude = locations.first.latitude;
        longitude = locations.first.longitude;
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
    }
    return (latitude, longitude);
  }
}
