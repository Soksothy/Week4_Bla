import '../model/ride/ride.dart';
import '../model/ride_pref/ride_pref.dart';
import '../model/ride/ride_filter.dart';
import '../model/ride/ride_sort_type.dart';

abstract class RidesRepository {
  List<Ride> getRides(
      RidePreference preference, RidesFilter? filter, RideSortType? sortType);
}
