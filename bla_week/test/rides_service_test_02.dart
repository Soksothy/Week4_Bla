import 'package:test/test.dart';
import 'package:bla_week/repository/mock/mock_rides_repository.dart';
import 'package:bla_week/service/rides_service.dart';
import 'package:bla_week/model/ride_pref/ride_pref.dart';
import 'package:bla_week/model/ride/ride_filter.dart';
import 'package:bla_week/model/ride/ride_sort_type.dart';
import 'package:bla_week/model/ride/locations.dart';
import 'package:bla_week/model/ride/ride.dart';

void main() {
  // Use setUpAll for one-time setup before all tests
  setUpAll(() {
    RidesService.initialize(MockRidesRepository());
  });

  group('RidesService Tests', () {
    test(
        'T1: Should return 4 rides for Battambang to SiemReap with 1 passenger',
        () {
      // Create a ride preference with fixed date for reproducible tests
      final preference = RidePreference(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'SiemReap', country: Country.cambodia),
        departureDate:
            DateTime(2023, 9, 15), // Fixed date for consistent results
        requestedSeats: 1,
      );

      // Get rides matching the preference
      final rides = RidesService.instance
          .getRides(preference, null, RideSortType.departureTime);

      // Print the rides for console output in a structured way
      print('\nFor your preference (Battambang -> SiemReap, 1 passenger):');
      for (final ride in rides) {
        final departureTime = formatTime(ride.departureDate);
        final duration =
            '${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours';
        final seats = '${ride.availableSeats} seats';
        print(
            '- $departureTime | ${ride.driver.firstName} | $seats | $duration');
      }

      // Assertions using equals() matcher
      expect(rides.length, equals(4),
          reason: "Expected exactly 4 rides for the given preference");
      expect(rides.where((ride) => ride.availableSeats == 0).length, equals(0),
          reason: "Expected no fully booked rides in the results");
    });

    test('T2: Should return rides with pet allowed including one by Mengtech',
        () {
      // Create a ride preference
      final preference = RidePreference(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'SiemReap', country: Country.cambodia),
        departureDate: DateTime(2023, 9, 15),
        requestedSeats: 1,
      );

      // Create a rides filter with pet allowed
      final filter = RidesFilter(petAccepted: true);

      // Get rides matching the preference and filter
      final rides = RidesService.instance
          .getRides(preference, filter, RideSortType.departureTime);

      // Print the rides for console output
      print('\nFor your preference with pet allowed:');
      for (final ride in rides) {
        final departureTime = formatTime(ride.departureDate);
        final duration =
            '${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours';
        print(
            '- $departureTime | ${ride.driver.firstName} | Pet allowed: ✓ | $duration');
      }

      print("______________________________________________________");

      // Assertions with specific matchers
      expect(rides, isNotEmpty,
          reason: "Expected at least one ride with pet allowed");
      expect(rides.any((ride) => ride.driver.firstName == 'Mengtech'), isTrue,
          reason: "Expected Mengtech to be one of the drivers allowing pets");
    });
  });
}

// Helper function for formatting time
String formatTime(DateTime dateTime) {
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour < 12 ? 'am' : 'pm';
  return '$hour:$minute $period';
}
