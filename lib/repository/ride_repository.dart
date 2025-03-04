
// Abstract repository for rides
import 'package:week_3_blabla_project/repository/mock/mock_ride_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidesPreference preference, RidesFilter? filter);
}