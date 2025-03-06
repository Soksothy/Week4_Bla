import '../model/ride_pref/ride_pref.dart';
import '../model/ride/ride.dart';
import '../model/ride/ride_filter.dart';
import '../repository/rides_repository.dart';

class RidesService {
  static RidesService? _instance;
  final RidesRepository repository;

  RidesService._internal(this.repository);

  static void initialize(RidesRepository repository) {
    if (_instance == null) {
      _instance = RidesService._internal(repository);
    } else {
      throw Exception("RidesService is already initialized.");
    }
  }

  static RidesService get instance {
    if (_instance == null) {
      throw Exception("RidesService is not initialized. Call initialize() first.");
    }
    return _instance!;
  }

  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return repository.getRides(preference, filter);
  }
}