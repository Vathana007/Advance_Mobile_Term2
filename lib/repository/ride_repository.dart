
// Abstract repository for rides
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePref preference, RidesFilter? filter);
}