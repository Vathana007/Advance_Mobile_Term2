import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
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
  bool get _isFormFieldValid =>
      departure != null &&
      arrival != null &&
      departureDate.isAfter(DateTime.now());

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

  void _handleDepartureSelect(Location location) {}

  void _handleArrivalSelect(Location location) {}

  void _handleDateSelect(DateTime date) {}

  void _handleSeatsSelect(int seats) {}

  // Creates and submits a RidePref object when form is valid
  void _handleSubmit() {
    if (_isFormFieldValid) {
      widget.onSubmit(RidePref(
        departure: departure!,
        arrival: arrival!,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      ));
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Departure Location Input
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Departure Input Field
              _departureField(
                label: 'Leaving from',
                initialLocation: departure,
                onLocationSelected: _handleDepartureSelect,
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
          // Arrival location field
          _departureField(
            label: 'Going to',
            initialLocation: arrival,
            onLocationSelected: _handleArrivalSelect,
            icon: Icons.radio_button_checked_outlined,
          ),
          const BlaDivider(),

          // Date selection field
          _dateField(),
          const BlaDivider(),

          // Passenger count field
          _passengerField(requestedSeats),
          const SizedBox(height: BlaSpacings.xl),

          // Submit button
          BlaButton(
            label: 'Search',
            onPressed: _handleSubmit,
          )
        ],
      ),
    );
  }
}

// Implement a location selection field
Widget _departureField({
  required String label,
  required Location? initialLocation,
  required ValueChanged<Location> onLocationSelected,
  required IconData icon,
}) {
  return InkWell(
    onTap: () {
      // TODO: Implement on location selection
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: BlaSpacings.s),
      child: Row(
        children: [
          Icon(
            icon,
            color: BlaColors.neutralLight,
            size: 24,
          ),
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
