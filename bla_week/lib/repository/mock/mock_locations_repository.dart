import '../../model/ride/locations.dart';
import '../locations_repository.dart';

class MockLocationsRepository extends LocationsRepository {
  final List<Location> _locations = [
    Location(name: "Phnom Penh", country: Country.cambodia),
    Location(name: "Siem Reap", country: Country.cambodia),
    Location(name: "Battambang", country: Country.cambodia),
    Location(name: "Sihanoukville", country: Country.cambodia),
    Location(name: "Kampot", country: Country.cambodia),
  ];

  @override
  List<Location> getLocations() {
    return _locations;
  }
}