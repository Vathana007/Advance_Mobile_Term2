import 'package:flutter/material.dart';
import '../../../../model/ride/locations.dart';
import '../../../../dummy_data/dummy_data.dart';
import '../../../../theme/theme.dart';

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
        _filteredLocations =
            []; // Check to clear the list when search the list is empty
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: BlaColors.backgroundAccent,
                borderRadius: BorderRadius.circular(12), // Rounded edges
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios_new,
                        color: BlaColors.neutralLighter, size: 20),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search for a city',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                      autofocus: true,
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () => _searchController.clear(),
                      child: Icon(Icons.close, color: BlaColors.neutralLighter),
                    ),  
                ],
              ),
            ),
          ),

          // Search results
          Expanded(
            child: _searchController.text.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Start typing to search for a location',
                        style: TextStyle(color: BlaColors.neutralLight, fontSize: 16),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    itemCount: _filteredLocations.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final location = _filteredLocations[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        leading: index < 3
                            ? Icon(Icons.history, color: BlaColors.neutralLight)
                            : Icon(Icons.location_on, color: BlaColors.neutralLight),
                        title: Text(
                          location.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          location.country.name,
                          style:
                              TextStyle(fontSize: 14, color: BlaColors.neutralLight),
                        ),
                        trailing:
                            Icon(Icons.chevron_right, color: BlaColors.neutralLight),
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
