import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text('Ride Search Results')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Departure: $departure', style: TextStyle(fontSize: 18)),
            Text('Arrival: $arrival', style: TextStyle(fontSize: 18)),
            Text(
              'Date: ${DateTimeUtils.formatDateTime(date)}',
              style: TextStyle(fontSize: 18),
            ),
            Text('Seats: $seats', style: TextStyle(fontSize: 18)),
            BlaDivider(),
          ],
        ),
      ),
    );
  }
}