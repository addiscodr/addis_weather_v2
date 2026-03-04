//ignore_for_file: public_member_api_docs, sort_constructors_first
class FamousCity {
  final String name;
  final double lat;
  final double lon;

  FamousCity({required this.name, required this.lat, required this.lon});
}

List<FamousCity> famousCities = [
  FamousCity(name: 'Lodon', lat: 51.5074, lon: -0.1278),

  FamousCity(name: 'Paris', lat: 48.8566, lon: 2.3522),

  FamousCity(name: 'New York', lat: 40.7128, lon: -74.0060),

  FamousCity(name: 'Sydney', lat: -33.8688, lon: 151.2093),
];
