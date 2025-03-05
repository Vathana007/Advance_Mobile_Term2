import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_location_repository.dart';
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';

void main() {
  // Ensure RidesService is initialized once
  RidesService.initialize(MockRidesRepository());

  // Use MockLocationsRepository to get mock locations
  final locationsRepo = MockLocationsRepository();
  final locations = locationsRepo.getLocations();

  RidePref pref = RidePref(
    departure: locations[2], // e.g., Battambang
    departureDate: DateTime.now(),
    arrival: locations[1], // e.g., Siem Reap
    requestedSeats: 1,
  );

  RidesFilter filter1 = RidesFilter(acceptPets: false);
  RidesFilter filter2 = RidesFilter(acceptPets: true);

  List<Ride> getRidesFor(RidePref preference, RidesFilter? filter) {
    MockRidesRepository repository = MockRidesRepository();
    List<Ride> rides = repository.getRides(preference, filter, null);

    List<Ride> filteredRides = rides.where((ride) {
      bool isValidLocation = ride.departureLocation.name == preference.departure.name &&
          ride.arrivalLocation.name == preference.arrival.name;

      bool isValidDate = ride.departureDate.year == preference.departureDate.year &&
          ride.departureDate.month == preference.departureDate.month &&
          ride.departureDate.day == preference.departureDate.day;
      
      // Allow false pet filter to include both pet-accepting and non-pet rides
      bool isValidPets = filter == null || !filter.acceptPets || ride.acceptPets == filter.acceptPets;
      
      return isValidLocation && isValidDate && isValidPets;
    }).toList();

    return filteredRides;
  }

  test('Battambang -> SiemReap, today, 1 passenger', () {
    var rides = getRidesFor(pref, filter1);

    print('For your preference (${pref.departure.name} -> ${pref.arrival.name}, today 1 passenger) we found ${rides.length} rides:');
    for (var ride in rides) {
      String formattedTime = '${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')} ${ride.departureDate.hour < 12 ? 'am' : 'pm'}';
      print('- at $formattedTime with ${ride.driver.firstName} (${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours)');
    }

    expect(rides.length, greaterThan(1)); // More than 1 ride should be returned
  });

  test('Battambang -> SiemReap, today, 1 passenger and accept pets', () {
    var rides = getRidesFor(pref, filter2);

    print('For your preference (${pref.departure.name} -> ${pref.arrival.name}, today 1 passenger and accepting pets) we found ${rides.length} rides:');
    for (var ride in rides) {
      String formattedTime = '${ride.departureDate.hour}:${ride.departureDate.minute.toString().padLeft(2, '0')} ${ride.departureDate.hour < 12 ? 'am' : 'pm'}';
      print('- at $formattedTime with ${ride.driver.firstName} (${ride.arrivalDateTime.difference(ride.departureDate).inHours} hours)');
    }

    expect(rides.length, greaterThanOrEqualTo(1)); // At least 1 ride should match
  });
}
