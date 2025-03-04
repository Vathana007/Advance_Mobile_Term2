// Placeholder classes for Ride and RidesPreference
import 'package:week_3_blabla_project/repository/ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

class Ride {
  final String id;
  final String departure;
  final String arrival;
  final String dateDep;
  final String duration;
  final String user;
  final bool acceptPets;
  final int seats;

  Ride({
    required this.id,
    required this.departure,
    required this.arrival,
    required this.dateDep,
    required this.duration,
    required this.user,
    required this.acceptPets,
    required this.seats,
  });
}

class RidesPreference {
  final String preferredDestination;

  RidesPreference({required this.preferredDestination, required String preferredDeparture});
}

// Mock implementation of RidesRepository
class MockRidesRepository extends RidesRepository {
  final List<Ride> _rides = [
    Ride(id: '1', departure: 'Battambang', arrival: 'Siem Reap', dateDep: 'Today at 5:30 am', duration: '2 hours', user: 'Kannika', acceptPets: false, seats: 2),
    Ride(id: '2', departure: 'Battambang', arrival: 'Siem Reap', dateDep: 'Today at 8 pm', duration: '2 hours', user: 'Chaylim', acceptPets: false, seats: 0),
    Ride(id: '3', departure: 'Battambang', arrival: 'Siem Reap', dateDep: 'Today at 5 am', duration: '3 hours', user: 'Mengtech', acceptPets: false, seats: 1),
    Ride(id: '4', departure: 'Battambang', arrival: 'Siem Reap', dateDep: 'Today at 8 pm', duration: '2 hours', user: 'Limhao', acceptPets: true, seats: 2),
    Ride(id: '5', departure: 'Battambang', arrival: 'Siem Reap', dateDep: 'Today at 5 am', duration: '3 hours', user: 'Sovanda', acceptPets: false, seats: 1),
  ];

  @override
  List<Ride> getRides(RidesPreference preference, RidesFilter? filter) {
    return _rides.where((ride) {
      final matchesDestination = ride.arrival == preference.preferredDestination;
      final matchesPetFilter = filter == null || ride.acceptPets == filter.acceptPets;
      return matchesDestination && matchesPetFilter;
    }).toList();
  }
}
