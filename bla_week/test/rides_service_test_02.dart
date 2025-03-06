import 'package:flutter_test/flutter_test.dart';
import 'package:bla_week/repository/mock/mock_rides_repository.dart';
import 'package:bla_week/service/rides_service.dart';
import 'package:bla_week/model/ride_pref/ride_pref.dart';
import 'package:bla_week/model/ride/ride_filter.dart';
import 'package:bla_week/model/ride/ride_sort_type.dart';
import 'package:bla_week/model/ride/locations.dart';
import 'package:bla_week/model/ride/ride.dart';

void main() {
  // Initialize the RidesService with the MockRidesRepository
  RidesService.initialize(MockRidesRepository());
  
  group('RidesService Tests', () {
    test('T1: Create a ride preference and assert 4 results are displayed', () {
      // Create a ride preference
      RidePreference preference = RidePreference(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'SiemReap', country: Country.cambodia),
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );
      
      // Get rides matching the preference
      var rides = RidesService.instance.getRides(preference, null, RideSortType.departureTime);
      
      // Print the rides for console output
      print('\nFor your preference (Battambang -> SiemReap, today 1 passenger) we founded ${rides.length} rides:');
      for (var ride in rides) {
        var departureTime = '${ride.departureDate.hour.toString().padLeft(2, '0')}.${ride.departureDate.minute.toString().padLeft(2, '0')} ${ride.departureDate.hour < 12 ? 'am' : 'pm'}';
        var duration = '${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours';
        print('- at $departureTime\t\twith ${ride.driver.firstName}\t ($duration)');
      }
      
      // Assertions
      expect(rides.length, 4, reason: "Expected 4 rides for the given preference");
      expect(rides.where((ride) => ride.availableSeats == 0).length, 1, reason: "Expected 1 ride to be full");
    });
    
    test('T2: Create a ride preference with pet filter and assert 1 result', () {
      // Create a ride preference
      RidePreference preference = RidePreference(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'SiemReap', country: Country.cambodia),
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );
      
      // Create a rides filter with pet allowed
      RidesFilter filter = RidesFilter(petAccepted: true);
      
      // Get rides matching the preference and filter
      var rides = RidesService.instance.getRides(preference, filter, RideSortType.departureTime);
      
      // Print the rides for console output
      print('\nFor your preference (Battambang -> SiemReap, today 1 passenger) with pet allowed we founded ${rides.length} rides:');
      for (var ride in rides) {
        var departureTime = '${ride.departureDate.hour.toString().padLeft(2, '0')}.${ride.departureDate.minute.toString().padLeft(2, '0')} ${ride.departureDate.hour < 12 ? 'am' : 'pm'}';
        var duration = '${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours';
        print('- at $departureTime\t\twith ${ride.driver.firstName}\t ($duration)');
      }
      
      // Assertions
      expect(rides.length, greaterThanOrEqualTo(1), reason: "Expected at least one ride for the given preference with pet allowed");
      expect(rides.any((ride) => ride.driver.firstName == 'Mengtech'), isTrue, reason: "Expected one of the drivers to be Mengtech");
    });
  });
}