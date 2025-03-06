import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../model/ride/locations.dart';
import '../../model/user/user.dart';
import '../../model/ride/ride_filter.dart';
import '../rides_repository.dart';

class MockRidesRepository extends RidesRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 5, minutes: 30)),
      arrivalDateTime: DateTime.now().add(Duration(hours: 7, minutes: 30)),
      driver: User(
        firstName: 'Kannika',
        lastName: '',
        email: 'kannika@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 10.0,
      acceptPets: false,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 20)),
      arrivalDateTime: DateTime.now().add(Duration(hours: 22)),
      driver: User(
        firstName: 'Chaylim',
        lastName: '',
        email: 'chaylim@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 0,
      pricePerSeat: 10.0,
      acceptPets: false,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 5)),
      arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
      driver: User(
        firstName: 'Mengtech',
        lastName: '',
        email: 'mengtech@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 10.0,
      acceptPets: false,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 20)),
      arrivalDateTime: DateTime.now().add(Duration(hours: 22)),
      driver: User(
        firstName: 'Limhao',
        lastName: '',
        email: 'limhao@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 10.0,
      acceptPets: true,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 5)),
      arrivalDateTime: DateTime.now().add(Duration(hours: 8)),
      driver: User(
        firstName: 'Sovanda',
        lastName: '',
        email: 'sovanda@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 10.0,
      acceptPets: false,
    ),
  ];

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return _rides.where((ride) {
      if (filter != null && filter.petAccepted && !ride.acceptPets) {
        return false;
      }
      return ride.departureLocation.name == preference.departure.name &&
          ride.arrivalLocation.name == preference.arrival.name;
    }).toList();
  }
}