import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/locations_repository.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  final LocationsRepository locationsRepository;
  static const List<Location> availableLocations = fakeLocations;   // TODO for now fake data
  
  LocationsService(this.locationsRepository);

  List<Location> getLocations() {
    return locationsRepository.getLocations();
  }
}