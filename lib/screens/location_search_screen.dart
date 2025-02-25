import 'package:flutter/material.dart';
import '../../model/ride/locations.dart';
import '../../dummy_data/dummy_data.dart';
import '../../theme/theme.dart';

class LocationSearchScreen extends StatefulWidget {
  final String? initialQuery;

  const LocationSearchScreen({
    super.key,
    this.initialQuery,
  });

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Location> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery ?? '';
    if (widget.initialQuery?.isNotEmpty ?? false) {
      _onSearchChanged(); // It's filter when there's an initial query
    }
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredLocations = []; // Check to clear the list when search the list is empty
      } else {
        _filteredLocations = fakeLocations.where((location) {
          return location.name.toLowerCase().startsWith(query) ||
              location.country.name.toLowerCase().startsWith(query);
        }).toList();

        // Sort the filter of locations alphabetically by name
        _filteredLocations.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BlaColors.white,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp, color: BlaColors.neutralLight),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Station Road or The Bridge Cafe',
            border: InputBorder.none,
          ),
          style: BlaTextStyles.body.copyWith(color: BlaColors.neutralDark),
          autofocus: true,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: BlaColors.neutralLight),
            onPressed: () {
              if (_searchController.text.isEmpty) {
                Navigator.pop(context);
              } else {
                _searchController.clear();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_searchController.text.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Search for location',
                  style: TextStyle(
                    color: BlaColors.neutralLight,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: _filteredLocations.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final location = _filteredLocations[index];
                  return ListTile(
                    leading: index < 3
                        ? Icon(Icons.schedule, color: BlaColors.neutralLight)
                        : null,
                    title: Text(
                      location.name,
                      style: BlaTextStyles.body.copyWith(
                        color: BlaColors.textNormal,
                      ),
                    ),
                    subtitle: Text(
                      location.country.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                    onTap: () => Navigator.pop(context, location),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
