import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';

class RideSearchResultsScreen extends StatelessWidget {
  final String departure;
  final String arrival;
  final DateTime date;
  final int seats;

  const RideSearchResultsScreen({
    super.key,
    required this.departure,
    required this.arrival,
    required this.date,
    required this.seats,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlaColors.white, // Set dark theme background

      // App Bar
      appBar: AppBar(
        backgroundColor: BlaColors.white, 
        title: Text(
          'Ride Search Results',
          style: TextStyle(color: BlaColors.neutralDark), 
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.blue), 
        elevation: 0, 
      ),

      // Page Content
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ride Details Card
            Card(
              color: BlaColors.neutralLighter, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), 
              ),
              elevation: 4, 
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Departure Information
                    Row(
                      children: [
                        const Icon(Icons.radio_button_checked, color: Colors.blue), 
                        const SizedBox(width: 10), 
                        Text(
                          departure,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10), 

                    // Arrival Information
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red), 
                        const SizedBox(width: 10),
                        Text(
                          arrival,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10), 
                    BlaDivider(), 
                    const SizedBox(height: 10), 

                    // Date Information
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.orange), 
                        const SizedBox(width: 10),
                        Text(
                          'Date: ${DateTimeUtils.formatDateTime(date)}', 
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10), 

                    // Seats Information
                    Row(
                      children: [
                        const Icon(Icons.event_seat, color: Colors.blue), 
                        const SizedBox(width: 10),
                        Text(
                          'Seats: $seats', 
                          style: const TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40), 

            // "Search Another Ride" Button
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), 
              ),
              child: const Text(
                "Search Another Ride",
                style: TextStyle(fontSize: 18, color: Colors.white), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
