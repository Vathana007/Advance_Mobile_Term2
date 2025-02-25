import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/location_search_screen.dart';
// import 'widgets/actions/bla_button.dart';
import 'theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: LocationSearchScreen()),
    );
  }
}