import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/location_search_screen.dart';
import 'package:week_3_blabla_project/screens/ride_search_screen.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/animations_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  /// Callback triggered when form is submitted
  final ValueChanged<RidePref> onSubmit;

  const RidePrefForm({super.key, this.initRidePref, required this.onSubmit});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  // Select departure location
  Location? departure;

  // Select departure time
  late DateTime departureDate;

  // Select arrival location
  Location? arrival;

  // Number of Passenger
  late int requestedSeats;

  /// Valid Form when both locations and date are selected
  bool get _isFormFieldValid => departure != null && arrival != null;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    _initializeFormData();
  }

  // Initialize form fields from provided RidePref or defaults value
  void _initializeFormData() {
    final pref = widget.initRidePref;
    departure = pref?.departure;
    arrival = pref?.arrival;
    departureDate = pref?.departureDate ?? DateTime.now();
    requestedSeats = pref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // Handle to open LocationSearchScreen with Bottom-to-Top transition
  Future<void> _handleDepartureSelect() async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(const LocationSearchScreen()),
    );
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

// Handle to open LocationSearchScreen with Bottom-to-Top transition
  Future<void> _handleArrivalSelect() async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      AnimationUtils.createBottomToTopRoute(const LocationSearchScreen()),
    );
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void _handleDateSelect(DateTime date) {}

  void _handleSeatsSelect(int seats) {}

  // Creates and submits a RidePref object when form is valid
  void _handleSubmit() {
    if (_isFormFieldValid) {
      // Navigate to RideSearchScreen when form is valid
      Navigator.push(
        context,
        AnimationUtils.createBottomToTopRoute(
          RideSearchResultsScreen(
            departure: departure!.name,
            arrival: arrival!.name,
            date: departureDate,
            seats: requestedSeats,
          ),
        ),
      );
    } else {
      // Show error message if form is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select departure and arrival locations'),
        ),
      );
    }
  }

  // Switches departure and arrival locations when both already selected
  void _handleLocationSwitch() {
    if (departure != null && arrival != null) {
      setState(() {
        final temp = departure;
        departure = arrival;
        arrival = temp;
      });
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Departure location field with correct onTap
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _departureField(
                label: 'Leaving from',
                initialLocation: departure,
                onTap: _handleDepartureSelect, // Pass function reference
                icon: Icons.radio_button_checked_outlined,
              ),
              // Add switch button between locations
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.swap_vert),
                  onPressed: _handleLocationSwitch,
                  color: BlaColors.neutralLight,
                  tooltip: 'Switch locations',
                ),
              ),
            ],
          ),
          const BlaDivider(),

          // Arrival location field with correct onTap
          _departureField(
            label: 'Going to',
            initialLocation: arrival,
            onTap: _handleArrivalSelect, // Pass function reference
            icon: Icons.location_on_outlined,
          ),
          const BlaDivider(),

          // Date selection field
          _dateField(),
          const BlaDivider(),

          // Passenger count field
          _passengerField(requestedSeats),
          const SizedBox(height: BlaSpacings.xl),

          BlaButton(
            label: 'Search',
            onPressed: _handleSubmit,
          ),
        ],
      ),
    );
  }
}

// Implement a location selection field
Widget _departureField({
  required String label,
  required Location? initialLocation,
  required VoidCallback onTap,
  required IconData icon,
}) {
  return InkWell(
    onTap: onTap, // Call function when tap
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(icon, color: BlaColors.neutralLight, size: 24),
          const SizedBox(width: BlaSpacings.m),
          Text(
            initialLocation?.name ?? label,
            style: BlaTextStyles.body.copyWith(
              color: initialLocation != null
                  ? BlaColors.textNormal
                  : BlaColors.textLight,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Implement the date selection field
Widget _dateField() {
  return InkWell(
    onTap: () {
      // TODO: Implement date selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: BlaColors.neutralLight,
            size: 24,
          ),
          const SizedBox(width: BlaSpacings.m),
          Text(
            'Today',
            style: BlaTextStyles.body.copyWith(
              color: BlaColors.textNormal,
            ),
          ),
        ],
      ),
    ),
  );
}

// Implement the passenger count selection field
Widget _passengerField(dynamic requestedSeats) {
  return InkWell(
    onTap: () {
      // TODO: Implement passenger selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(
            Icons.person_outline,
            color: BlaColors.neutralLight,
            size: 24,
          ),
          const SizedBox(width: BlaSpacings.m),
          Text(
            '$requestedSeats',
            style: BlaTextStyles.body.copyWith(
              color: BlaColors.textNormal,
            ),
          ),
        ],
      ),
    ),
  );
}
