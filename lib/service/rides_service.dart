import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  static List<Ride> availableRides = fakeRides;   // TODO for now fake data


  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePref preferences) {
    //  print(availableRides);
    
    // For now, just a test
    return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
  }
 
}

///
/// Display available ride today
///
void main() {
  DateTime today = DateTime.now();

  List<Ride> todayRides = RidesService.availableRides.where((ride) {
    DateTime rideDate = ride.departureDate; // Ensure departureDate is a DateTime object
    return rideDate.year == today.year &&
        rideDate.month == today.month &&
        rideDate.day == today.day;
  }).toList();

  ///
  /// Check condition if not empty, display all available rides for today
  ///
  if (todayRides.isNotEmpty) { 
    print('Available rides for today:\n');
    for (var ride in todayRides) { 
      print('From: ${ride.departureLocation}');
      print('To: ${ride.arrivalLocation}');
      print('Date: ${ride.departureDate}');
      print('Price: ${ride.pricePerSeat}€');
      print('Driver: ${ride.driver}');
      print('---------------------');
    }
  } else {
    print('No rides available today.');
  }
}