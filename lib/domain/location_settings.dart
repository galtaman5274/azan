// models/location_settings.dart
class LocationSettings {
  String? country;
  String? state;
  String? city;
  String latitude = '';
  String longitude = '';

  LocationSettings({
    this.country = 'US',
    this.state,
    this.city,
    this.latitude = '',
    this.longitude = '',
  });
}
